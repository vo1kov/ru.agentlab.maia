package ru.agentlab.maia.messaging

import ru.agentlab.maia.IMessage

interface IMessageDeliveryService {

	def void send(IMessage message)

	def void addReceiveListener(IMessageDeliveryEventListener listener)

}