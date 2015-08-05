package ru.agentlab.maia.admin.bundles

import com.jayway.jsonpath.JsonPath
import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import io.netty.handler.codec.http.websocketx.TextWebSocketFrame
import org.osgi.framework.BundleEvent
import ru.agentlab.maia.admin.bundles.internal.Activator

class WsSubscribeBundleHandler extends ChannelHandlerAdapter {

	val static COMMAND = "bundles-subscribe"

	override channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
		if (msg instanceof String) {
			val type = JsonPath.read(msg, "$.command") as String
			if (COMMAND.equalsIgnoreCase(type)) {
				Activator.context.addBundleListener [ event |
					var e = switch (event.type) {
						case BundleEvent.INSTALLED: {
							"installed"
						}
						case BundleEvent.LAZY_ACTIVATION: {
							"lazy_activation"
						}
						case BundleEvent.RESOLVED: {
							"resolved"
						}
						case BundleEvent.STARTED: {
							"started"
						}
						case BundleEvent.STARTING: {
							"starting"
						}
						case BundleEvent.STOPPED: {
							"stopped"
						}
						case BundleEvent.STOPPING: {
							"stopping"
						}
						case BundleEvent.UNINSTALLED: {
							"uninstalled"
						}
						case BundleEvent.UNRESOLVED: {
							"unresolved"
						}
						case BundleEvent.UPDATED: {
							"updated"
						}
					}
					ctx.writeAndFlush(new TextWebSocketFrame('''
						{
							"command" : "«COMMAND»", 
							"content" : {
								"bundle" : "«event.bundle.bundleId»",
								"type" : "«e»"
							}
						}
					'''))
				]
			}
			ctx.fireChannelRead(msg)
		} else {
			ctx.fireChannelRead(msg)
		}
	}

}