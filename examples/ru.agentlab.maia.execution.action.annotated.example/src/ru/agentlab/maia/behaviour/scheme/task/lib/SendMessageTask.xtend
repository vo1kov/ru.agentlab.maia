package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageDeliveryService

class SendMessageTask {

	@Input
	IMessage message

	@Inject
	IMessageDeliveryService messageDeliveryService

	@Action
	def void action() {
		messageDeliveryService.send(message)
	}

}