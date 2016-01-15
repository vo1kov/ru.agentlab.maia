package ru.agentlab.maia.admin.containers

import io.netty.channel.ChannelHandlerAdapter
import io.netty.channel.ChannelHandlerContext
import ru.agentlab.maia.event.IMaiaEventBroker

class WsContextSubscribeHandler extends ChannelHandlerAdapter {

	IMaiaEventBroker broker

	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override channelActive(ChannelHandlerContext ctx) throws Exception {
//		broker.subscribe(MaiaContextFactoryCreateChildEvent.TOPIC, [ IMaiaEvent event |
//			if (event instanceof MaiaContextFactoryCreateChildEvent) {
//				val parent = event.parentContext
//				val child = event.context
//
//				ctx.writeAndFlush(new TextWebSocketFrame('''
//					{
//						"command" : "context-list", 
//						"content" : {
//							"name" : "�child.toString�",
//							"uuid" : "�child.uuid�",
//							"type" : "�child.get(IMaiaContextTyping.KEY_TYPE)�"
//						}
//					}
//				'''))
//			}
//		])
	}

}