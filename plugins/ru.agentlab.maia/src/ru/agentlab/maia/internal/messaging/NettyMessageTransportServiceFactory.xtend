package ru.agentlab.maia.internal.messaging

import ru.agentlab.maia.messaging.IMessageTransportServiceFactory

class NettyMessageTransportServiceFactory implements IMessageTransportServiceFactory {
	
	override create() {
		return new NettyMessageTransportService
	}
	
}