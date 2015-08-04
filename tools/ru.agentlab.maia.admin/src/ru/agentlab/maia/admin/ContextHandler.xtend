package ru.agentlab.maia.admin

import io.netty.buffer.Unpooled
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.DefaultFullHttpResponse
import io.netty.handler.codec.http.HttpHeaderNames
import io.netty.handler.codec.http.HttpRequest
import io.netty.handler.codec.http.HttpResponseStatus
import io.netty.handler.codec.http.HttpVersion
import org.restexpress.url.UrlPattern
import ru.agentlab.maia.context.IMaiaContext

class ContextHandler extends ChannelHandlerAdapter {

	UrlPattern pattern = new UrlPattern("/contexts/{id}")

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof HttpRequest) {
			if (pattern.matches(msg.uri)) {
				val match = pattern.match(msg.uri)
				val id = match.get("id").replaceAll("%20", " ")
				val rootContext = Activator.rootContext
				val found = rootContext.findContext(id)
				println(found)
				val response = if (found != null) {
						val buffer = Unpooled.wrappedBuffer(found.dump.bytes)
						new DefaultFullHttpResponse(
							HttpVersion.HTTP_1_1,
							HttpResponseStatus.OK,
							buffer
						) => [
							headers.add(HttpHeaderNames.CONTENT_LENGTH, buffer.capacity.toString)
							headers.add(HttpHeaderNames.ACCESS_CONTROL_ALLOW_ORIGIN, "*")
						]
					} else {
						val resp = Unpooled.wrappedBuffer("Not found".bytes)
						new DefaultFullHttpResponse(
							HttpVersion.HTTP_1_1,
							HttpResponseStatus.NOT_FOUND,
							resp
						) => [
							headers.add(HttpHeaderNames.CONTENT_LENGTH, resp.capacity.toString)
							headers.add(HttpHeaderNames.ACCESS_CONTROL_ALLOW_ORIGIN, "*")
						]
					}
				ctx.writeAndFlush(response)
			} else {
				ctx.fireChannelRead(msg)
			}
		} else {
			ctx.fireChannelRead(msg)
		}
	}

	def IMaiaContext findContext(IMaiaContext context, String id) {
		if (context.uuid.equalsIgnoreCase(id)) {
			return context
		} else {
			if (!context.childs.empty) {
				for (child : context.childs) {
					var childResult = child.findContext(id)
					if (childResult != null) {
						return childResult
					}
				}
			} else {
				return null
			}
		}
	}

}