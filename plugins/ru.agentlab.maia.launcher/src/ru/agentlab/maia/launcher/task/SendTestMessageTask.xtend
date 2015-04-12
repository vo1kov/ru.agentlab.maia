package ru.agentlab.maia.launcher.task

import java.util.UUID
import javax.inject.Inject
import org.maia.task.Action
import org.slf4j.LoggerFactory
import ru.agentlab.maia.launcher.BehaviourExample2
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageFactory

class SendTestMessageTask {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample2)

	@Inject
	IMessageDeliveryService messageDelivery

	@Inject
	IMessageFactory messageFactory

	@Action
	def void action() {
		LOGGER.info("Create message...")
		val message = messageFactory.create => [
			receivers += UUID.randomUUID.toString
		]
		LOGGER.info("Send message...")
		messageDelivery.send(message)
	}

}