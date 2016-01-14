package ru.agentlab.maia.admin.contexts

import com.jayway.jsonpath.JsonPath
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import ru.agentlab.maia.IContainer
import ru.agentlab.maia.admin.contexts.internal.Activator

class WsContextListHandler extends ChannelHandlerAdapter {

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof String) {
			val type = JsonPath.read(msg, "$.command") as String
			if ("context-list".equalsIgnoreCase(type)) {
				val rootContext = Activator.rootContext
				ctx.writeAndFlush(new TextWebSocketFrame('''
					{
						"command" : "context-list", 
						"content" : «rootContext.serialize»
					}
				'''))
			}
			ctx.fireChannelRead(msg)
		} else {
			ctx.fireChannelRead(msg)
		}
	}

	def String serialize(IContainer context) {
		if (context.childs.empty) {
			return '''
				{
					"name" : "«context.toString»",
					"uuid" : "«context.uuid»",
				}
			'''
		} else {
			return '''
				{
					"name" : "«context.toString»",
					"uuid" : "«context.uuid»",
					"children" : [
				«««						«FOR child : context.childs SEPARATOR ","»
«««							«child.serialize»
«««						«ENDFOR»
					]
				}
			'''
		}
	}

}
