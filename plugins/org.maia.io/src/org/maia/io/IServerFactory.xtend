package org.maia.io

import io.netty.bootstrap.ServerBootstrap
import io.netty.channel.ChannelHandler
import io.netty.channel.ChannelOption
import io.netty.channel.ServerChannel

interface IServerFactory {

	val static String KEY_BOSS_GROUP = "mts.group.boss"

	def ServerBootstrap createServer(Class<? extends ServerChannel> channelClass, ChannelHandler handler, int port)

	def <T> void setOption(ServerBootstrap bootstrap, ChannelOption<T> option, T value)

}