package ru.agentlab.maia.internal.messaging

import io.netty.bootstrap.Bootstrap
import io.netty.bootstrap.ServerBootstrap
import io.netty.buffer.Unpooled
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.nio.NioServerSocketChannel
import io.netty.channel.socket.nio.NioSocketChannel
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageTransportEventListener
import ru.agentlab.maia.messaging.INettyMessageTransportService

class NettyMessageTransportService implements INettyMessageTransportService {

	val serverBootstrap = new ServerBootstrap

	val clientBootstrap = new Bootstrap

	val bossGroup = new NioEventLoopGroup

	val workerGroup = new NioEventLoopGroup

	@Inject @Named(KEY_SERVER_HANDLER)
	var ChannelHandler serverHandler

	@Inject @Named(KEY_CLIENT_HANDLER)
	var ChannelHandler clientHandler

	@PostConstruct
	def void init() {
		try {
			serverBootstrap => [
				group(bossGroup, workerGroup)
				channel = NioServerSocketChannel
				childHandler(serverHandler)
//					new ChannelInitializer<SocketChannel>() { // (4)
//					override public void initChannel(SocketChannel ch) throws Exception {
//						ch.pipeline.addLast(new DiscardServerHandler)
//					}
//				})
				option(ChannelOption.SO_BACKLOG, 128) // (5)
				childOption(ChannelOption.SO_KEEPALIVE, true) // (6)
			]
			clientBootstrap => [
				group(workerGroup)
				channel = NioSocketChannel
				option(ChannelOption.TCP_NODELAY, true)
				handler(clientHandler)
//					new ChannelInitializer<SocketChannel>() { // (4)
//					override public void initChannel(SocketChannel ch) throws Exception {
//						ch.pipeline.addLast(new DiscardServerHandler)
//					}
//				})
			]

		// Bind and start to accept incoming connections.
//			val f = serverBootstrap.bind(port).sync() // (7)
		// Wait until the server socket is closed.
		// In this example, this does not happen, but you can do that to gracefully
		// shut down your server.
//			f.channel().closeFuture().sync()
		} finally {
			workerGroup.shutdownGracefully()
			bossGroup.shutdownGracefully()
		}

	}

	@PreDestroy
	def void destroy() {
		workerGroup.shutdownGracefully
		bossGroup.shutdownGracefully
	}

	override send(IMessage message) {
		message.receivers.forEach [
			val channel = clientBootstrap.connect("127.0.0.1", 8899).sync.channel
			if (channel.isWritable()) {
				println("SEND HELLO " + "HELLO".bytes)
				channel.writeAndFlush(Unpooled.wrappedBuffer("HELLO".bytes));
			}
		]
	}

	override addReceiveListener(IMessageTransportEventListener listener) {
	}

//	def public static void main(String[] args) throws Exception {
//		val port = Integer.parseInt(args.get(0))
//		(new MessageTransportService).run(port)
//	}
}