package ru.agentlab.maia.launcher.task

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.launcher.BehaviourExample2
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageFactory

class SendTestMessageTask {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample2)

	@Inject
	IMessageDeliveryService messageDelivery

	@Inject
	IMessageFactory messageFactory

	@Inject
	IAgentIdFactory agentIdFactory

	@Action
	def void action() {
		LOGGER.info("Create message...")
		val message = messageFactory.create => [
			receivers += agentIdFactory.create(null, "Agent1")
		]
		LOGGER.info("Send message...")
		messageDelivery.send(message)
	}

}