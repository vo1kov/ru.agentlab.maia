package ru.agentlab.maia.agent

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

/**
 * Factory for creating Agent contexts
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class AgentFactory implements IAgentFactory {

	val static LOGGER = LoggerFactory.getLogger(AgentFactory)

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextFactory contextFactory

	@Inject
	IMaiaContextServiceManagementService contextServiceManagementService

	@Inject
	MaiaAgentProfile agentProfile

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
	@Create
	override createAgent(IMaiaContext parentContext) {
		val context = if (parentContext != null) {
				parentContext
			} else {
				this.context
			}
		LOGGER.info("Create new Agent...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Create Agent Name...")
		val namingService = contextServiceManagementService.createService(agentProfile, parentContext,
			IMaiaContextNameFactory)
		if (namingService == null) {
			throw new IllegalStateException("Agent Profile have no required IMaiaContextNameFactory")
		}
		val name = namingService.createName
		LOGGER.debug("	generated name: [{}]", name)

		LOGGER.info("Create new context...")
		val agentContext = contextFactory.createChild(context, "Context for Agent: " + name) => [
			set(IMaiaContextNameFactory.KEY_NAME, name)
		]

		LOGGER.info("Create Agent specific services...")
		contextServiceManagementService => [ manager |
			agentProfile.implementationKeySet.forEach [
				manager.createService(agentProfile, agentContext, it)
			]
			agentProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(agentProfile, context, agentContext, it)
			]
		]
		LOGGER.info("Agent successfully created!")
		return agentContext
	}

}