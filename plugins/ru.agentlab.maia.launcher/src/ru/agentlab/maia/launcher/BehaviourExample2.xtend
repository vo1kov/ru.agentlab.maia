package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.messaging.IMessageDeliveryService
import ru.agentlab.maia.messaging.IMessageFactory

class BehaviourExample2 {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample2)

	@Inject
	@Named(IContextFactory.KEY_NAME)
	String behName

	@Inject
	IMessageDeliveryService messageDelivery

	@Inject
	IMessageFactory messageFactory

	@Inject
	IAgentIdFactory agentIdFactory

	@Inject
	IEclipseContext context

	@PostConstruct
	def void init() {
		var c = context
		while (c != null) {
			LOGGER.debug("Context [{}] hold:", c)
			(c as EclipseContext).localData.forEach [ p1, p2 |
				LOGGER.debug("	[{}] -> [{}]", p1, p2)
			]
			c = c.parent
		}
	}

	@Action
	def void action() {
		LOGGER.info("Create message...")
		val message = messageFactory.create => [
			receivers += agentIdFactory.create(null, "sss")
		]
		LOGGER.info("Send message...")
		messageDelivery.send(message)
		LOGGER.info("Behaviour2 [{}] timestamp [{}]", behName, System.currentTimeMillis)
	}

}