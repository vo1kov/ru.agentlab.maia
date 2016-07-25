package ru.agentlab.maia.messaging

import ru.agentlab.maia.message.IMessage

interface IMessageDeliveryEventListener {

	def void onReceive(IMessage message)

}