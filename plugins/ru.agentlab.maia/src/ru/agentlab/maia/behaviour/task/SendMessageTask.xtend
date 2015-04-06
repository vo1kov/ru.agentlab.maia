package ru.agentlab.maia.behaviour.task

import javax.inject.Inject
import ru.agentlab.maia.Action
import ru.agentlab.maia.TaskInput
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageDeliveryService

class SendMessageTask {

	@TaskInput
	IMessage message

	@Inject
	IMessageDeliveryService messageDeliveryService

	@Action
	def void action() {
		messageDeliveryService.send(message)
	}

}