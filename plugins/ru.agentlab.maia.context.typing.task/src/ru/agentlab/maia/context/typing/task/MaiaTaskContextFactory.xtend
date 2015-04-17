package ru.agentlab.maia.context.typing.task

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService
import ru.agentlab.maia.context.typing.IMaiaContextTyping

class MaiaTaskContextFactory implements IMaiaTaskContextFactory {

	val static LOGGER = LoggerFactory.getLogger(MaiaTaskContextFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManagementService serviceManager

	@Inject
	MaiaTaskProfile profile

	/**
	 * <p>Create Task-Context with default set of agent-specific services.</p>
	 * <p>That implementation of factory create Context with following services:</p>
	 * <ul>
	 * <li>{@link IScheduler IScheduler} - allow agent and all its childs schedules behaviours
	 * and control agent lifecycle</li>
	 * <li>{@link IMessageQueue IMessageQueue} - allow agent and all its childs receives messages</li>
	 * </ul>
	 * <p>Task-Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains agent name</li>
	 * {@link IContextFactory#TYPE_AGENT AGENT} value</li>
	 * <li>{@link ITaskId ITaskId} - Id of agent</li>
	 * </ul>
	 * {@link ITaskNameGenerator ITaskNameGenerator} will be used for generating agent name.
	 */
	@Create
	override createTask(IMaiaContext parentContext) {
		val context = if (parentContext != null) {
				parentContext
			} else {
				this.context
			}
		LOGGER.info("Create new Task...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Create Task Name...")
		val namingService = context.get(IMaiaContextNameFactory)
		if (namingService == null) {
			throw new IllegalStateException("Task Profile have no required IMaiaContextNameFactory")
		}
		val name = namingService.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create new context...")
		val agentContext = contextFactory.createChild(context, "MAIA Task context: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
			set(IMaiaContextTyping.KEY_TYPE, "MAIA Task")
		]

		LOGGER.info("Create Task specific services...")
		serviceManager => [ manager |
			profile.implementationKeySet.forEach [
				manager.createService(profile, agentContext, it)
			]
			profile.factoryKeySet.forEach [
				manager.createServiceFromFactory(profile, context, agentContext, it)
			]
		]
		LOGGER.info("Task successfully created!")
		return agentContext
	}

}