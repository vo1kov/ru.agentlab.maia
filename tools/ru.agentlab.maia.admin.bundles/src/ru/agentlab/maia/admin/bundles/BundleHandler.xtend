package ru.agentlab.maia.admin.bundles

import com.jayway.jsonpath.JsonPath
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import org.eclipse.osgi.util.ManifestElement
import org.osgi.framework.Bundle
import org.osgi.framework.Constants
import ru.agentlab.maia.admin.bundles.internal.Activator

class BundleHandler extends ChannelHandlerAdapter {

	val static COMMAND = "bundles"

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof String) {
			val type = JsonPath.read(msg, "$.command") as String
			if (COMMAND.equalsIgnoreCase(type)) {
				ctx.writeAndFlush(new TextWebSocketFrame('''
					{
						"command" : "«COMMAND»", 
						"content" : [
							«FOR bundle : Activator.context.bundles SEPARATOR ","»
								«bundle.serialize»
							«ENDFOR»
						]
					}
				'''))
			}
			ctx.fireChannelRead(msg)
		} else {
			ctx.fireChannelRead(msg)
		}
	}

	def String serialize(Bundle bundle) {
		'''
			{
				"name" : "«bundle.symbolicName»",
				"id" : "«bundle.bundleId»",
				"state" : "«bundle.stateString»",
				"imports" : [
					«val req = bundle.headers.get("Require-Bundle")»
					«IF req != null»
						«FOR elem : ManifestElement.parseHeader(Constants.REQUIRE_BUNDLE, req) SEPARATOR ","»
							"«elem.value»"
						«ENDFOR»
					«ENDIF»
				]
			}
		'''
	}

	def private static String getStateString(Bundle bundle) {
		val type = bundle.state;
		switch (type) {
			case type == Bundle.INSTALLED: {
				return "installed";
			}
			case type == Bundle.RESOLVED: {
				return "resolved";
			}
			case type == Bundle.STARTING: {
				return "starting";
			}
			case type == Bundle.ACTIVE: {
				return "active";
			}
			case type == Bundle.STOPPING: {
				return "stopping";
			}
			case type == Bundle.UNINSTALLED: {
				return "uninstalled";
			}
			default: {
				return "unknown event type: " + type;
			}
		}
	}

}