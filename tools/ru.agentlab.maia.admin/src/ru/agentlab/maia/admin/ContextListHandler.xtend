package ru.agentlab.maia.admin

import io.netty.buffer.Unpooled
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.DefaultFullHttpResponse
import io.netty.handler.codec.http.HttpHeaderNames
import io.netty.handler.codec.http.HttpRequest
import io.netty.handler.codec.http.HttpResponseStatus
import io.netty.handler.codec.http.HttpVersion
import ru.agentlab.maia.context.IMaiaContext

class ContextListHandler extends ChannelHandlerAdapter {

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof HttpRequest) {
			if (msg.uri == "/contexts") {
				val rootContext = Activator.rootContext
				val buffer = Unpooled.wrappedBuffer(rootContext.serialize.toString.bytes)
				val response = new DefaultFullHttpResponse(
					HttpVersion.HTTP_1_1,
					HttpResponseStatus.OK,
					buffer
				) => [
					headers.add(HttpHeaderNames.CONTENT_LENGTH, buffer.capacity.toString)
					headers.add(HttpHeaderNames.ACCESS_CONTROL_ALLOW_ORIGIN, "*")
				]
				// println(rootContext.serialize)
				ctx.writeAndFlush(response)
			} else {
				ctx.fireChannelRead(msg)
			}
		} else {
			ctx.fireChannelRead(msg)
		}
	}

	def String serialize(IMaiaContext context) {
		if (context.childs.empty) {
			return '''
				{
					"name" : "«context.toString»",
					"uuid" : "«context.uuid»",
					"type" : "«context.get(IMaiaContext.KEY_TYPE)»"
				}
			'''
		} else {
			return '''
				{
					"name" : "«context.toString»",
					"uuid" : "«context.uuid»",
					"type" : "«context.get(IMaiaContext.KEY_TYPE)»",
					"children" : [
						«FOR child : context.childs SEPARATOR ","»
							«child.serialize»
						«ENDFOR»
					]
				}
			'''
		}
	}

}