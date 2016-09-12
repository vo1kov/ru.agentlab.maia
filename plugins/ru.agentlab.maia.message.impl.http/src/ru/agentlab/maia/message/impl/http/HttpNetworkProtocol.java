package ru.agentlab.maia.message.impl.http;

import com.google.gson.Gson;

import io.netty.bootstrap.Bootstrap;
import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelHandler;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;
import io.netty.handler.codec.http.HttpClientCodec;
import io.netty.handler.codec.http.HttpObjectAggregator;
import io.netty.handler.codec.http.HttpServerCodec;
import ru.agentlab.maia.message.INetworkProtocol;

public class HttpNetworkProtocol implements INetworkProtocol {

	Gson gson = new Gson();

	@Override
	public Bootstrap getClientBootstrap(EventLoopGroup workerGroup, ChannelHandler lastHandler) {
		Bootstrap bootstrap = new Bootstrap();
		bootstrap.group(workerGroup);
		bootstrap.channel(NioSocketChannel.class);
		bootstrap.handler(new ChannelInitializer<SocketChannel>() {
			@Override
			public void initChannel(SocketChannel channel) throws Exception {
				ChannelPipeline pipeline = channel.pipeline();
				pipeline.addLast(new HttpClientCodec());
				pipeline.addLast(new HttpObjectAggregator(1048576));
				pipeline.addLast(new HttpRequestContentDecoder());
				pipeline.addLast(new HttpRequestContentEncoder());
				pipeline.addLast(new AclMessageEncoder(gson));
				pipeline.addLast(new AclMessageDecoder(gson));
				if (lastHandler != null) {
					pipeline.addLast(lastHandler);
				}
			}
		});
		bootstrap.option(ChannelOption.SO_KEEPALIVE, true);
		return bootstrap;
	}

	@Override
	public ServerBootstrap getServerBootstrap(EventLoopGroup workerGroup, EventLoopGroup bossGroup,
			ChannelHandler lastHandler) {
		ServerBootstrap serverBootstrap = new ServerBootstrap();
		serverBootstrap.group(bossGroup, workerGroup);
		serverBootstrap.channel(NioServerSocketChannel.class);
		serverBootstrap.childHandler(new ChannelInitializer<SocketChannel>() {
			@Override
			public void initChannel(SocketChannel channel) throws Exception {
				ChannelPipeline pipeline = channel.pipeline();
				pipeline.addLast(new HttpServerCodec());
				pipeline.addLast(new HttpObjectAggregator(1048576));
				pipeline.addLast(new HttpRequestContentDecoder());
				pipeline.addLast(new HttpRequestContentEncoder());
				pipeline.addLast(new AclMessageEncoder(gson));
				pipeline.addLast(new AclMessageDecoder(gson));
				if (lastHandler != null) {
					pipeline.addLast(lastHandler);
				}
			}
		});
		serverBootstrap.option(ChannelOption.SO_BACKLOG, 128);
		serverBootstrap.childOption(ChannelOption.SO_KEEPALIVE, true);
		return serverBootstrap;
	}

}
