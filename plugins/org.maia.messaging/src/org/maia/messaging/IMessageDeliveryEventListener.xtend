package org.maia.messaging

interface IMessageDeliveryEventListener {

	def void onReceive(IMessage message)

}