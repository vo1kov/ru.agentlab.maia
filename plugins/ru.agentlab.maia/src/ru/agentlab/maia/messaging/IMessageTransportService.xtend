package ru.agentlab.maia.messaging

interface IMessageTransportService {

	def void send(IMessage message)

	def void addReceiveListener(IMessageTransportEventListener listener)

}