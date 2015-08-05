package ru.agentlab.maia.messaging.netty.internal

import io.netty.bootstrap.Bootstrap
import io.netty.bootstrap.ServerBootstrap
import io.netty.buffer.Unpooled
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption
import io.netty.channel.socket.nio.NioServerSocketChannel
import io.netty.channel.socket.nio.NioSocketChannel
import io.netty.handler.codec.http.DefaultFullHttpRequest
import io.netty.handler.codec.http.HttpMethod
import io.netty.handler.codec.http.HttpVersion
import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.di.annotations.Optional
import org.slf4j.LoggerFactory
import ru.agentlab.maia.io.IClientFactory
import ru.agentlab.maia.io.IServerFactory
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageDeliveryEventListener
import ru.agentlab.maia.messaging.netty.INettyMessageDeliveryService
import ru.agentlab.maia.messaging.queue.IMessageQueue

class NettyMessageDeliveryService implements INettyMessageDeliveryService {

	val static LOGGER = LoggerFactory.getLogger(NettyMessageDeliveryService)

	var ServerBootstrap serverBootstrap

	var Bootstrap clientBootstrap

	@Inject @Named(KEY_SERVER_HANDLER) @Optional
	var ChannelHandler serverHandler

	@Inject @Named(KEY_CLIENT_HANDLER) @Optional
	var ChannelHandler clientHandler

	@Inject @Named(KEY_PORT)
	var int port

	@Inject
	IClientFactory clientFactory

	@Inject
	IServerFactory serverFactory

//	@Inject
//	IAgentRegistry agentRegistryLocal

	@PostConstruct
	def void init() {
		try {
			clientBootstrap = clientFactory.createClient(NioSocketChannel, clientHandler) => [
				clientFactory.setOption(it, ChannelOption.TCP_NODELAY, false)
			]
			serverBootstrap = serverFactory.createServer(NioServerSocketChannel, serverHandler, port) => [
				serverFactory.setOption(it, ChannelOption.SO_KEEPALIVE, true)
				serverFactory.setOption(it, ChannelOption.SO_BACKLOG, 128)
			]
		} finally {
		}

	}

	override send(IMessage message) {
		LOGGER.info("Try to send [{}] message...", message)
		message.receivers.forEach [
			LOGGER.info("Try to find [{}] agent in local...", it)
//			val agent = agentRegistryLocal.get(it)
//			if (agent != null) {
//				LOGGER.info("	Agent [{}] have found in local", it)
//				val queue = agent.get(IMessageQueue)
//				queue.addLast(message)
//			} else {
//				LOGGER.info("	Agent [{}] have not found in local", it)
//				LOGGER.info("Try to find [{}] agent in platform...", it)
//
//				LOGGER.info("	Agent [{}] have found in platform", it)
//			}
//			val address = addresses.get(0)
//			new InetSocketAddress(address)
			clientBootstrap.connect("127.0.0.1", 8899) => [ future |
				future.addListener [
					if (success) {
						val channel = future.channel
						if (channel.isWritable()) {
							val msg = new DefaultFullHttpRequest(HttpVersion.HTTP_1_1, HttpMethod.GET, "localhost",
								Unpooled.wrappedBuffer("HELLO".bytes)) => []
							LOGGER.info("SEND HELLO " + "HELLO".bytes)
							channel.writeAndFlush(msg)
							channel.close
						}
					} else {
//						clientBootstrap.releaseExternalResources();
//						throw new ConnectionException("Something bad happened...");
					}
				]
			]
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

}