package org.maia.internal

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.maia.IBehaviourFactory
import org.maia.initializer.IInitializerService
import org.maia.naming.IBehaviourNameGenerator
import org.maia.service.IServiceManagementService
import org.maia.task.scheduler.IBehaviour
import org.maia.task.scheduler.scheme.IBehaviourScheme
import org.maia.task.scheduler.scheme.IBehaviourSchemeRegistry
import org.maia.task.scheduler.scheme.internal.PropertyIndex
import org.maia.task.scheduler.scheme.mapping.IBehaviourPropertyMapping
import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMapping
import org.maia.task.scheduler.scheme.mapping.IBehaviourTaskMappingFactory
import org.slf4j.LoggerFactory

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
			createService(result, IBehaviourTaskMapping)
			createService(result, IBehaviourTaskMappingFactory)
			createService(result, PropertyIndex)
			createService(result, IBehaviourPropertyMapping)
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