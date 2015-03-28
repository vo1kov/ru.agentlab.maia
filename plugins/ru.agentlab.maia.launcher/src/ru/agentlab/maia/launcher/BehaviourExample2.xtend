package ru.agentlab.maia.launcher

import javax.inject.Inject
import javax.inject.Named
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.agent.IAgentIdFactory
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.messaging.IMessageDeliveryService

class BehaviourExample2 {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample2)

	@Inject
	@Named(IBehaviour.KEY_NAME)
	String behName

	@Inject
	IMessageDeliveryService messageDelivery

	@Inject
	IMessageFactory messageFactory
	
	@Inject
	IAgentIdFactory agentIdFactory

	@Action(type=IBehaviour.TYPE_ONE_SHOT)
	def void action() {
		val message = messageFactory.create => [
			receivers += agentIdFactory.create(null, "sss")
		]
		messageDelivery.send(message)
		LOGGER.info("Behaviour [{}] timestamp [{}]", behName, System.currentTimeMillis)
	}

}