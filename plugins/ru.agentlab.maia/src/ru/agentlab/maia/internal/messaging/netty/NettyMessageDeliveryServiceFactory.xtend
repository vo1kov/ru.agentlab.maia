package ru.agentlab.maia.internal.messaging.netty

import io.netty.channel.ChannelInitializer
import io.netty.channel.nio.NioEventLoopGroup
import io.netty.channel.socket.SocketChannel
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.internal.messaging.netty.NettyMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageDeliveryServiceFactory
import ru.agentlab.maia.messaging.netty.INettyMessageDeliveryService

class NettyMessageDeliveryServiceFactory implements IMessageDeliveryServiceFactory {

	@Inject
	IEclipseContext context

	override create() {
		context => [
			set(INettyMessageDeliveryService.KEY_BOSS_GROUP, new NioEventLoopGroup)
			set(INettyMessageDeliveryService.KEY_WORKER_GROUP, new NioEventLoopGroup)
			set(INettyMessageDeliveryService.KEY_CLIENT_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline.addLast(new ru.agentlab.maia.internal.messaging.DiscardServerHandler)
				}
			})
			set(INettyMessageDeliveryService.KEY_SERVER_HANDLER, new ChannelInitializer<SocketChannel>() { // (4)
				override public void initChannel(SocketChannel ch) throws Exception {
					ch.pipeline.addLast(new ru.agentlab.maia.internal.messaging.DiscardServerHandler)
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