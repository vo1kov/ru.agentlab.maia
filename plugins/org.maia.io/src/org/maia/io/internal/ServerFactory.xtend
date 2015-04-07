package org.maia.io.internal

import io.netty.bootstrap.ServerBootstrap
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption
import io.netty.channel.EventLoopGroup
import io.netty.channel.ServerChannel
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.io.IClientFactory
import org.maia.io.IServerFactory
import org.slf4j.LoggerFactory

class ServerFactory implements IServerFactory {

	val static LOGGER = LoggerFactory.getLogger(ServerFactory)

	@Inject
	IEclipseContext context

	override createServer(Class<? extends ServerChannel> channelClass, ChannelHandler handler, int port) {
		LOGGER.info("Create Server...")
		val workerGroup = context.get(IClientFactory.KEY_WORKER_GROUP) as EventLoopGroup
		if (workerGroup == null) {
			throw new IllegalStateException("Event Loop workerGroup is null")
		}
		val bossGroup = context.get(KEY_BOSS_GROUP) as EventLoopGroup
		if (bossGroup == null) {
			throw new IllegalStateException("Event Loop bossGroup is null")
		}
		val serverBootstrap = new ServerBootstrap => [
			group(bossGroup, workerGroup)
			channel(channelClass)
			childHandler(handler)
		]

		val bindFuture = serverBootstrap.bind(port)
		bindFuture.addListener [ e |
			LOGGER.info("Server successfully created on [{}] port", port)
		]
		return serverBootstrap
	}

	override <T> setOption(ServerBootstrap bootstrap, ChannelOption<T> option, T value) {
		LOGGER.debug("	Add option [{}]=[{}]", option, value)
		bootstrap.option(option, value)
	}

}