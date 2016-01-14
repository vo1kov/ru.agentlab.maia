package ru.agentlab.maia.admin.contexts

import com.jayway.jsonpath.JsonPath
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import ru.agentlab.maia.IContainer
import ru.agentlab.maia.admin.contexts.internal.Activator

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
	
	def String dump(IContainer context) {
		val list = context.keySet.sortWith [ a, b |
			a.compareTo(b)
		]
		val res = '''
			{
				"name" : "«this.toString»",
				"services" : [
					«FOR p1 : list SEPARATOR ","»
						«val value = context.get(p1)»
						{
							"key" : "«p1»",
							"value" : "«IF value != null»«value.class.name + "@" + Integer.toHexString(System.identityHashCode(value))»«ENDIF»",
							"type" : "«value?.class?.name»"
«««							«IF value != null && !value.class.isPrimitive && value.class != String»,
«««								"fields" : [
«««									«FOR field : value.class.declaredFields SEPARATOR ","»
«««										{
«««											"name" : "«field.name»",
«««											«field.setAccessible(true)»
«««											«val fieldValue = field.get(value)»
«««											"value" : "«IF fieldValue != null»«fieldValue.class.name + "@" + Integer.toHexString(System.identityHashCode(fieldValue))»«ELSE»null«ENDIF»"
«««										}
«««									«ENDFOR»
«««								]
«««							«ENDIF»
						}
					«ENDFOR»
				]
			}
		'''
		println(res)
		return res.toString
	}

	def IContainer findContext(IContainer context, String id) {
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