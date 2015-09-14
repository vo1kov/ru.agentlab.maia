package ru.agentlab.maia.messaging.netty.internal

import io.netty.channel.ChannelInitializer
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.SocketChannel
import io.netty.handler.codec.http.HttpClientCodec
import io.netty.handler.codec.http.HttpServerCodec
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.netty.INettyMessageDeliveryService

class NettyMessageDeliveryServiceFactory implements IMessageDeliveryServiceFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	override create() {
		context => [
			putService(INettyMessageDeliveryService.KEY_BOSS_GROUP, new NioEventLoopGroup)
			putService(INettyMessageDeliveryService.KEY_WORKER_GROUP, new NioEventLoopGroup)
			putService(INettyMessageDeliveryService.KEY_CLIENT_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline => [
						addLast(new LoggingHandler)
//						addLast(new Base64Encoder)
						addLast(new HttpClientCodec)
					]
				}
			})
			putService(INettyMessageDeliveryService.KEY_SERVER_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline => [
						addLast(new LoggingHandler)
						addLast(new HttpServerCodec)
//						addLast(new Base64Decoder)
					]
				}
			})
			val portString = System.getProperty("port", "8888")
			val port = Integer.parseInt(portString)
			putService(INettyMessageDeliveryService.KEY_PORT, port)
		]

		val service = injector.make(NettyMessageDeliveryService)
		injector.invoke(service, PostConstruct, null)
		return service
	}

}