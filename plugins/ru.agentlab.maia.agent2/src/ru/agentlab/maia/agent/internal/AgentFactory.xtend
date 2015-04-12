package ru.agentlab.maia.agent.internal

import java.util.UUID
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.IMaiaContextFactory
import ru.agentlab.maia.IMaiaContextServiceManager
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.initializer.IMaiaContextInitializerService
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.naming.IMaiaContextNameFactory
import ru.agentlab.maia.execution.scheduler.ISchedulerFactory

/**
 * Factory for creating Agent-Contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class AgentFactory implements IAgentFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

//	@Inject
//	IMaiaContextNameFactory contextNameFactory
//
	@Inject
	IMaiaContextServiceManager contextServiceManager

	/**
	 * <p>Create Agent-Context with default set of agent-specific services.</p>
	 * <p>That implementation of factory create Context with following services:</p>
	 * <ul>
	 * <li>{@link IScheduler IScheduler} - allow agent and all its childs schedules behaviours
	 * and control agent lifecycle</li>
	 * <li>{@link IMessageQueue IMessageQueue} - allow agent and all its childs receives messages</li>
	 * </ul>
	 * <p>Agent-Context will contain properties:</p>
	 * <ul>
	 * <li><code>context.name</code> - name of context, contains agent name</li>
	 * {@link IContextFactory#TYPE_AGENT AGENT} value</li>
	 * <li>{@link IAgentId IAgentId} - Id of agent</li>
	 * </ul>
	 * {@link IAgentNameGenerator IAgentNameGenerator} will be used for generating agent name.
	 */
	override createAgent(IMaiaContext parent) {
		val context = if (parent != null) {
				parent
			} else {
				this.context
			}
		LOGGER.info("Create new Agent...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Generate name...")
		val id = UUID.randomUUID.toString // contextNameFactory.createName
		LOGGER.debug("	generated name: [{}]", id)

		LOGGER.info("Create new context...")
		val agent = contextFactory.createChild(context, "Context for Agent: " + id) => [
			set(IMaiaContextNameFactory.KEY_NAME, id)
		]

		LOGGER.info("Add Agent-specific services...")
		contextServiceManager => [
			LOGGER.debug("	add agent scheduler...")
			getService(context, ISchedulerFactory) => [
				createScheduler(agent)
			]

			LOGGER.debug("	add lifecycle service...")
			getService(context, ILifecycleServiceFactory) => [
				createLifecycle(agent)
			]

			LOGGER.debug("	add initializer service...")
			getService(agent, IMaiaContextInitializerService)
		]

		LOGGER.info("Agent successfully created!")
		return agent
	}

}