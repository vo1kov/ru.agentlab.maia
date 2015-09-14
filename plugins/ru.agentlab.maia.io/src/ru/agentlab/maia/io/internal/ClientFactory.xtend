package ru.agentlab.maia.io.internal

import io.netty.bootstrap.Bootstrap
import io.netty.channel.Channel
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption
import io.netty.channel.EventLoopGroup
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.io.IClientFactory
import ru.agentlab.maia.memory.IMaiaContext

class ClientFactory implements IClientFactory {

	val static LOGGER = LoggerFactory.getLogger(ClientFactory)

	@Inject
	IMaiaContext context

	override createClient(Class<? extends Channel> channelClass, ChannelHandler handler) {
		LOGGER.info("Create Client...")
		val workerGroup = context.getService(KEY_WORKER_GROUP) as EventLoopGroup
		if (workerGroup == null) {
			throw new IllegalStateException("Event Loop is null")
		}
		val clientBootstrap = new Bootstrap => [
			group(workerGroup)
			channel(channelClass)
			handler(handler)
		]
		LOGGER.info("Client successfully created")
		return clientBootstrap
	}

	override <T> void setOption(Bootstrap bootstrap, ChannelOption<T> option, T value) {
		LOGGER.debug("	Add option [{}]=[{}]", option, value)
		bootstrap.option(option, value)
	}

}