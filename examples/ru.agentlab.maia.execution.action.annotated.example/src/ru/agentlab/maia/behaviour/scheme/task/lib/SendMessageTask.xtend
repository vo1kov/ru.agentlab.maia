package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.behaviour.annotation.Execute
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageDeliveryService

class SendMessageTask {

	@Input
	IMessage message

	@Inject
	IMessageDeliveryService messageDeliveryService

	@Execute
	def void action() {
		messageDeliveryService.send(message)
	}

}
