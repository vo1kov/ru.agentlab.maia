package ru.agentlab.maia.admin

import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext

class SomeHandler extends ChannelHandlerAdapter {

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		println
		println(msg)
		println
	}

}