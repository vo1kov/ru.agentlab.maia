package ru.agentlab.maia.context.typing.behaviour

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.typing.IMaiaContextTyping

class MaiaBehaviourContextFactory implements IMaiaBehaviourContextFactory {

	val static LOGGER = LoggerFactory.getLogger(MaiaBehaviourContextFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	MaiaBehaviourProfile behaviourProfile

	@Inject
	IMaiaContextServiceManagementService contextServiceManagementService

	override createBehaviour(IMaiaContext parentContext) {
		val context = if (parentContext != null) {
				parentContext
			} else {
				this.context
			}
		LOGGER.info("Create new Behaviour...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Create Behaviour Name...")
		val namingService = context.get(IMaiaContextNameFactory)
		if (namingService == null) {
			throw new IllegalStateException("Behaviour Profile have no required IMaiaContextNameFactory")
		}
		val name = namingService.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create Behaviour Context...")
		val behaviourContext = contextFactory.createChild(context, "Context for Behaviour: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
			set(IMaiaContextTyping.KEY_TYPE, "Behaviour")
		]

		LOGGER.info("Create Behaviour specific services...")
		contextServiceManagementService => [ manager |
			behaviourProfile.implementationKeySet.forEach [
				manager.createService(behaviourProfile, behaviourContext, it)
			]
			behaviourProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(behaviourProfile, context, behaviourContext, it)
			]
		]
		LOGGER.info("Behaviour successfully created!")
		return behaviourContext
	}

}