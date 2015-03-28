package ru.agentlab.maia.messaging

interface IMessageDeliveryEventListener {

	def void onReceive(IMessage message)

}