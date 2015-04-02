package ru.agentlab.maia.io

import io.netty.bootstrap.Bootstrap
import io.netty.channel.Channel
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption

interface IClientFactory {

	val static String KEY_WORKER_GROUP = "mts.group.worker"

	def Bootstrap createClient(Class<? extends Channel> channelClass, ChannelHandler handler)

	def <T> void setOption(Bootstrap bootstrap, ChannelOption<T> option, T value)

}