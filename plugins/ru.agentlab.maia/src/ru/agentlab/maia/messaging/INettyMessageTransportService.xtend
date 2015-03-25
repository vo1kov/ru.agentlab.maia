package ru.agentlab.maia.messaging

interface INettyMessageTransportService extends IMessageTransportService {
	
	val static String KEY_SERVER_HANDLER = "mts.server.handler" 
	
	val static String KEY_CLIENT_HANDLER = "mts.client.handler"
	
}