package ru.agentlab.maia.internal.messaging.netty

import io.netty.channel.ChannelInitializer
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.SocketChannel
import io.netty.handler.codec.http.HttpClientCodec
import io.netty.handler.codec.http.HttpServerCodec
import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.netty.INettyMessageDeliveryService

class NettyMessageDeliveryServiceFactory implements IMessageDeliveryServiceFactory {

	override create(IEclipseContext context) {
		context => [
			set(INettyMessageDeliveryService.KEY_BOSS_GROUP, new NioEventLoopGroup)
			set(INettyMessageDeliveryService.KEY_WORKER_GROUP, new NioEventLoopGroup)
			set(INettyMessageDeliveryService.KEY_CLIENT_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline => [
						addLast(new LoggingHandler)
//						addLast(new Base64Encoder)
						addLast(new HttpClientCodec)
					]
				}
			})
			set(INettyMessageDeliveryService.KEY_SERVER_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
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
			set(INettyMessageDeliveryService.KEY_PORT, port)
		]

		val service = ContextInjectionFactory.make(NettyMessageDeliveryService, context)
		ContextInjectionFactory.invoke(service, PostConstruct, null)
		return service
	}

}