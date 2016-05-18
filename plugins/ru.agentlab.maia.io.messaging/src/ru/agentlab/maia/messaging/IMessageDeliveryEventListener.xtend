package ru.agentlab.maia.messaging

import ru.agentlab.maia.IMessage

interface IMessageDeliveryEventListener {

	def void onReceive(IMessage message)

}