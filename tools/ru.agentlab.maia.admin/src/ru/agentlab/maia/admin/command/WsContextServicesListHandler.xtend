package ru.agentlab.maia.admin.command

import com.jayway.jsonpath.JsonPath
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import ru.agentlab.maia.admin.Activator
import ru.agentlab.maia.context.IMaiaContext

class WsContextServicesListHandler extends ChannelHandlerAdapter {

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof String) {
			val type = JsonPath.read(msg, "$.command") as String
			if ("services".equalsIgnoreCase(type)) {
				val context = JsonPath.read(msg, "$.parameters[0].context") as String
				val rootContext = Activator.rootContext
				val found = rootContext.findContext(context)
//				println(found)
				if (found != null) {
					ctx.writeAndFlush(new TextWebSocketFrame('''
						{
							"command" : "services", 
							"parameters" : [
								{"context" : "«context»"}
							],
							"content" : «found.dump»
						}
					'''))
				}
			}
			ctx.fireChannelRead(msg)
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