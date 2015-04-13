package ru.agentlab.maia.behaviour.internal

import java.util.UUID
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.execution.scheduler.ISchedulerFactory
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

//	@Inject
//	IMaiaContextNameFactory contextNameFactory
//	@Inject
//	IMaiaContextServiceManager contextServiceManager

	override createBehaviour() {
		LOGGER.info("Try to create new Default Container...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Generate Container Name...")
		val name = UUID.randomUUID.toString // contextNameFactory.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create Container Context...")
		val behaviour = contextFactory.createChild(context, "Context for Behaviour: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
		]

//		contextServiceManager => [
//			LOGGER.debug("	add agent scheduler...")
//			getService(context, ISchedulerFactory) => [
//				createScheduler(behaviour)
//			]
//
//			LOGGER.debug("	add lifecycle service...")
//			getService(context, ILifecycleServiceFactory) => [
//				createLifecycle(behaviour)
//			]
//
//			LOGGER.debug("	add initializer service...")
//			getService(behaviour, IMaiaContextInitializerService)
//		]

		LOGGER.info("Container successfully created!")
		return behaviour
	}

}