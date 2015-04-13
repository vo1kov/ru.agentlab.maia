package ru.agentlab.maia.agent

import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextFactory
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.service.Create
import ru.agentlab.maia.execution.scheduler.IScheduler
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.context.service.IMaiaContextServiceManagementService

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
	override createAgent(IMaiaContext parent) {
		val context = if (parent != null) {
				parent
			} else {
				this.context
			}
		LOGGER.info("Create new Agent...")
		LOGGER.debug("	home context: [{}]", context)

		LOGGER.info("Generate name...")
		var String generatedName = ""
		val namingService = agentProfile.getImplementation(IMaiaContextNameFactory)
		if (namingService != null) {
			val injector = context.get(IMaiaContextInjector)
			val nF = injector.make(namingService, context)
			generatedName = nF.createName
		}
		val id = generatedName // UUID.randomUUID.toString // contextNameFactory.createName
		LOGGER.debug("	generated name: [{}]", id)

		LOGGER.info("Create new context...")
		val agent = contextFactory.createChild(context, "Context for Agent: " + id) => [
			set(IMaiaContextNameFactory.KEY_NAME, id)
		]

		LOGGER.info("Create Agent specific services...")
		contextServiceManagementService => [ manager | 
			agentProfile.implementationKeySet.forEach [
				manager.createService(agentProfile, agent, it)
			]
			agentProfile.factoryKeySet.forEach [
				manager.createServiceFromFactory(agentProfile, context, agent, it)
			]
		]
		LOGGER.info("Agent successfully created!")
		return agent
	}

}