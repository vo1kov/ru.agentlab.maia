package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.behaviour.sheme.IBehaviourSchemeRegistry
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMapping
import ru.agentlab.maia.behaviour.sheme.IBehaviourTaskMappingFactory
import ru.agentlab.maia.initializer.IInitializerService
import ru.agentlab.maia.naming.IBehaviourNameGenerator
import ru.agentlab.maia.service.IServiceManagementService

class BehaviourFactory implements IBehaviourFactory {

	val static LOGGER = LoggerFactory.getLogger(BehaviourFactory)

	@Inject
	IEclipseContext context

	@Inject
	IBehaviourNameGenerator behaviourNameGenerator

	@Inject
	IServiceManagementService serviceManagementService

	@Inject
	IBehaviourSchemeRegistry behaviourSchemeRegistry

	override createDefault(String id) {
		LOGGER.info("Try to create new Default Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Create Behaviour instance...")
		serviceManagementService => [
			addService(result, IBehaviourScheme.name, behaviourSchemeRegistry.defaultScheme)
			createService(result, IBehaviourTaskMappingFactory)
			createService(result, IBehaviour)
			createService(result, IInitializerService)
		]

		result.runAndTrack(new BehaviourInstaller)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	override createEmpty(String id) {
		LOGGER.info("Try to create new Empty Behaviour...")
		LOGGER.debug("	home context: [{}]", context)
		LOGGER.debug("	behaviour Id: [{}]", id)

		val result = internalCreateEmpty(id)

		LOGGER.info("Behaviour successfully created!")
		return result
	}

	private def internalCreateEmpty(String id) {
		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Behaviour Name...")
				behaviourNameGenerator.generate
			}

		LOGGER.info("Create Behaviour Context...")
		val result = context.createChild("Context for Behaviour: " + name) => [
			declareModifiable(KEY_NAME)
			declareModifiable(IBehaviourScheme)
			declareModifiable(IBehaviourTaskMapping)
		]

		LOGGER.info("Add properties to Context...")
		context.get(IServiceManagementService) => [
			addService(result, KEY_NAME, name)
		]

		LOGGER.info("Add link for parent Context...")
		var behaviours = context.get(KEY_BEHAVIOURS) as List<IEclipseContext>
		if (behaviours == null) {
			LOGGER.debug("	Parent Context [{}] have no behaviours link, create new list...", context)
			behaviours = new ArrayList<IEclipseContext>
			context.set(KEY_BEHAVIOURS, behaviours)
		}
		behaviours += result
		return result
	}

}