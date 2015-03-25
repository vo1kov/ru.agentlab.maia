package ru.agentlab.maia.messaging

interface IMessageTransportEventListener {

	def void onReceive(IMessage message)

}