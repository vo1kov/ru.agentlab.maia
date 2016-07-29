package ru.agentlab.maia.message.impl;

import java.net.SocketAddress;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.inject.Inject;
import javax.inject.Named;

import io.netty.bootstrap.Bootstrap;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.MessageToMessageDecoder;
import io.netty.handler.codec.http.DefaultFullHttpResponse;
import io.netty.handler.codec.http.HttpClientCodec;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpResponseStatus;
import io.netty.handler.codec.http.HttpServerCodec;
import io.netty.handler.codec.http.HttpVersion;
import ru.agentlab.maia.agent.AgentAddress;
import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IAgentRegistry;
import ru.agentlab.maia.agent.LocalAgentAddress;
import ru.agentlab.maia.agent.RemoteAgentAddress;
import ru.agentlab.maia.message.IMessage;
import ru.agentlab.maia.message.IMessageDeliveryService;

public class HttpMessageDeliveryService implements IMessageDeliveryService {

	private ServerBootstrap serverBootstrap = new ServerBootstrap();

	private Bootstrap bootstrap = new Bootstrap();

	@Inject
	IAgentRegistry registry;

	private int port = 8080;

	@PostConstruct
	public void setup(@Named("worker-group") EventLoopGroup workerGroup,
			@Named("boss-group") EventLoopGroup bossGroup) {
		initServer(workerGroup, bossGroup);
		initClient(workerGroup);
	}

	private void initServer(EventLoopGroup workerGroup, EventLoopGroup bossGroup) {
		serverBootstrap.group(bossGroup, workerGroup);
		serverBootstrap.channel(NioServerSocketChannel.class);
		serverBootstrap.childHandler(new ChannelInitializer<SocketChannel>() {
			@Override
			public void initChannel(SocketChannel channel) throws Exception {
				ChannelPipeline pipeline = channel.pipeline();
				pipeline.addLast(new HttpServerCodec());
				pipeline.addLast(new HttpObjectAggregator(1048576));
				pipeline.addLast(new AclMessageEncoder());
				pipeline.addLast(new AclMessageDecoder());
				pipeline.addLast(new MessageToMessageDecoder<AclMessage>() {

					@Override
					protected void decode(ChannelHandlerContext ctx, AclMessage msg, List<Object> arg2)
							throws Exception {
						send(msg);
						ctx.writeAndFlush(new DefaultFullHttpResponse(HttpVersion.HTTP_1_1, HttpResponseStatus.OK));
						ctx.close();
					}
				});
			}
		});
		serverBootstrap.option(ChannelOption.SO_BACKLOG, 128);
		serverBootstrap.childOption(ChannelOption.SO_KEEPALIVE, true);
		serverBootstrap.bind(port).addListener((ChannelFuture future) -> {
			// int i = 0;
			// boolean success = future.isSuccess();
			// i++;
		});
	}

	private void initClient(EventLoopGroup workerGroup) {
		bootstrap.group(workerGroup);
		bootstrap.channel(NioSocketChannel.class);
		bootstrap.handler(new ChannelInitializer<SocketChannel>() {
			@Override
			public void initChannel(SocketChannel channel) throws Exception {
				ChannelPipeline pipeline = channel.pipeline();
				pipeline.addLast(new HttpClientCodec());
				pipeline.addLast(new HttpObjectAggregator(1048576));
				pipeline.addLast(new AclMessageEncoder());
				pipeline.addLast(new AclMessageDecoder());
			}
		});
		bootstrap.option(ChannelOption.SO_KEEPALIVE, true);
	}

	@Override
	public void send(IMessage message) {
		message.getReceivers().stream().forEach(uuid -> {
			AgentAddress address = registry.get(uuid);
			if (address == null) {
				throw new RuntimeException("Agent did not found");
			}
			if (address instanceof LocalAgentAddress) {
				IAgent agent = ((LocalAgentAddress) address).getAgent();
				sendInternal(message, agent);
			} else if (address instanceof RemoteAgentAddress) {
				sendExternal(message, ((RemoteAgentAddress) address).getAddress());
			}
		});
	}

	protected void sendInternal(IMessage message, IAgent agent) {
		agent.fireExternalEvent(message);
	}

	protected void sendExternal(IMessage message, SocketAddress address) {
		bootstrap.connect(address).addListener((ChannelFuture future) -> {
			if (future.isSuccess()) {
				Channel channel = future.channel();
				if (channel.isWritable()) {
					channel.writeAndFlush(message);
					channel.close();
				}
			} else {
				// clientBootstrap.releaseExternalResources();
				// throw new ConnectionException("Something bad
				// happened...");
			}
		});
	}

}
