package ru.agentlab.maia.internal.messaging.netty

import io.netty.buffer.ByteBuf
import io.netty.channel.ChannelHandlerContext
import io.netty.channel.ChannelInboundHandlerAdapter
import io.netty.util.ReferenceCountUtil

class LoggingHandler extends ChannelInboundHandlerAdapter {

	override channelRead(ChannelHandlerContext ctx, Object msg) {
		val in = msg as ByteBuf
		try {
//			System.out.print(msg)
			while (in.isReadable()) { // (1)
				System.out.print(in.readByte() as char);
				System.out.flush();
			}
		} finally {
			ReferenceCountUtil.release(msg) // (2)
		}
	}

	override exceptionCaught(ChannelHandlerContext ctx, Throwable cause) {
		// Close the connection when an exception is raised.
		cause.printStackTrace()
		ctx.close()
	}
}