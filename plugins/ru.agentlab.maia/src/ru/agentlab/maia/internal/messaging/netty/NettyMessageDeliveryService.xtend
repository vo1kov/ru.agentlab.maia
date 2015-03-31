package ru.agentlab.maia.internal.messaging.netty

import io.netty.bootstrap.Bootstrap
import io.netty.bootstrap.ServerBootstrap
import io.netty.buffer.Unpooled
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelInitializer
import io.netty.channel.ChannelOption
import io.netty.channel.EventLoopGroup
import io.netty.channel.socket.SocketChannel
import io.netty.channel.socket.nio.NioServerSocketChannel
import io.netty.channel.socket.nio.NioSocketChannel
import javax.annotation.PostConstruct
import javax.annotation.PreDestroy
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageDeliveryEventListener
import ru.agentlab.maia.messaging.netty.INettyMessageDeliveryService

class NettyMessageDeliveryService implements INettyMessageDeliveryService {

	val static LOGGER = LoggerFactory.getLogger(NettyMessageDeliveryService)

	var ServerBootstrap serverBootstrap

	var Bootstrap clientBootstrap

	@Inject
	@Named(KEY_WORKER_GROUP)
	var EventLoopGroup bossGroup

	@Inject
	@Named(KEY_WORKER_GROUP)
	var EventLoopGroup workerGroup

	@Inject
	@Named(KEY_SERVER_HANDLER)
	@Optional
	var package ChannelHandler serverHandler

	@Inject
	@Named(KEY_CLIENT_HANDLER)
	@Optional
	var package ChannelHandler clientHandler

	@Inject
	@Named(KEY_PORT)
	var package int port

//	@Inject
//	IMessageQueueFactory messageQueueFactory
//	var IMessageQueue inputQueue
//
//	var IMessageQueue outpuQueue
	@PostConstruct
	def void init() {
		try {
//			inputQueue = messageQueueFactory.get
//			outpuQueue = messageQueueFactory.get
			createBackend
			createFrontend
		// Bind and start to accept incoming connections.
		// Wait until the server socket is closed.
		// In this example, this does not happen, but you can do that to gracefully
		// shut down your server.
//			f.channel().closeFuture().sync()
		} finally {
//			workerGroup.shutdownGracefully()
//			bossGroup.shutdownGracefully()
		}

	}

	def void createBackend() {
		LOGGER.info("Try to create Message Transport Service server-side...")
		serverBootstrap = new ServerBootstrap => [
			group(bossGroup, workerGroup)
			channel = NioServerSocketChannel
			childHandler(serverHandler)
			LOGGER.debug("	Add option [{}]=[{}]", ChannelOption.SO_BACKLOG, 128)
			option(ChannelOption.SO_BACKLOG, 128)
			LOGGER.debug("	Add option [{}]=[{}]", ChannelOption.SO_KEEPALIVE, true)
			childOption(ChannelOption.SO_KEEPALIVE, true)
		]

		val bindFuture = serverBootstrap.bind(port)
		bindFuture.addListener [ e |
			LOGGER.info("Message Service server-side successfully created on [{}] port!", port)
		]
	}

	def void createFrontend() {
		LOGGER.info("Try to create Message Transport Service client-side...")
		clientBootstrap = new Bootstrap => [
			group(workerGroup)
			channel = NioSocketChannel
			LOGGER.debug("	Add option [{}]=[{}]", ChannelOption.TCP_NODELAY, true)
			option(ChannelOption.TCP_NODELAY, true)
			handler(clientHandler)
		]
		LOGGER.info("Message Service client-side successfully created!")
	}

	@PreDestroy
	def void destroy() {
//		workerGroup.shutdownGracefully
//		bossGroup.shutdownGracefully
	}

	override send(IMessage message) {
		LOGGER.info("Try to send [{}] message" + message)
		message.receivers.forEach [
//			val address = addresses?.get(0)
//			new InetSocketAddress(address)
			val channel = clientBootstrap.connect("127.0.0.1", 8899).sync.channel
			if (channel.isWritable()) {
				LOGGER.info("SEND HELLO " + "HELLO".bytes)
				channel.writeAndFlush(Unpooled.wrappedBuffer("HELLO".bytes));
			}
		]
	}

	def protected void sendSameContainer(IMessage message) {
	}

	def protected void sendDifferenContainer(IMessage message) {
		// send by IMTP
	}

	def protected void sendDifferenPlatform(IMessage message) {
		// send by IMTP to main and main-to-main by MTP
	}

	override addReceiveListener(IMessageDeliveryEventListener listener) {
	}

	def public static void main(String[] args) throws Exception {
		val port = Integer.parseInt(args.get(0))
		val service = new NettyMessageDeliveryService => [
			serverHandler = new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline.addLast(new LoggingHandler)
				}
			}
			clientHandler = new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline.addLast(new LoggingHandler)
				}
			}
			it.port = port
		]
		service.init

	}

}