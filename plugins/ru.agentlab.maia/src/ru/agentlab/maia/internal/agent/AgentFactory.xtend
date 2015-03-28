package ru.agentlab.maia.internal.agent

import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.agent.ISchedulerFactory
import ru.agentlab.maia.context.ContextExtension
import ru.agentlab.maia.internal.MaiaActivator
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageQueueFactory
import ru.agentlab.maia.naming.IAgentNameGenerator

class AgentFactory implements IAgentFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentFactory)

	extension ContextExtension = new ContextExtension(LOGGER)

	override createDefault(IEclipseContext root, String id) {
		LOGGER.info("Try to create new Agent...")
		LOGGER.debug("	Agent Id: [{}]", id)

		val context = createEmpty(root, id)
		val name = context.get(KEY_NAME) as String

//		(context as EclipseContext).localData.forEach [ p1, p2 |
//			LOGGER.info("Context Data: [{}] -> [{}]", p1, p2)
//		]
//		(context.parent as EclipseContext).localData.forEach [ p1, p2 |
//			LOGGER.info("ContextParent Data: [{}] -> [{}]", p1, p2)
//		]
//		var c = context.parent
//		while (c != null) {
//			LOGGER.info("Context [{}] hold:", c)
//			(c as EclipseContext).localData.forEach [ p1, p2 |
//				LOGGER.info("	[{}] -> [{}]", p1, p2)
//			]
//			c = c.parent
//		}
		val schedulerFactory = context.get(ISchedulerFactory)
		val scheduler = schedulerFactory.create(name)
		val messageQueueProvider = context.get(IMessageQueueFactory)
		val messageQueue = messageQueueProvider.get

		LOGGER.info("Create Agent-specific Services...")
		context => [
			// Every behaviour can access to scheduler
			addContextService(IScheduler, scheduler)
			// Every behaviour can access to message queue
			addContextService(IMessageQueue, messageQueue)
		]
		return context
	}

	/**
	 * Create empty Agent-Context
	 * 
	 * @param id
	 * 			- unique id of agent. If <code>null</code>, then <code>INameGenerator</code> 
	 * 			will be used for generating agent name.
	 */
	override createEmpty(IEclipseContext root, String id) {
		LOGGER.info("Try to create new empty Agent...")
		LOGGER.debug("	Agent Id: [{}]", id)

		LOGGER.info("Prepare Agent root context...")
		val rootContext = if (root != null) {
				root
			} else {
				LOGGER.info("Root context is null, get it from OSGI services...")
				MaiaActivator.osgiContext
			}

		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Agent Name...")
				val nameGenerator = rootContext.get(IAgentNameGenerator)
				val n = nameGenerator.generate(rootContext)
				LOGGER.debug("	Agent Name is [{}]", n)
				n
			}

		LOGGER.info("Create Agent Context...")
		val context = rootContext.createChild("Context for Agent: " + name) => [
			addContextProperty(KEY_NAME, name)
			addContextProperty(KEY_TYPE, "ru.agentlab.maia.agent")
		]

		LOGGER.info("Empty Agent successfully created!")
		return context
	}

}