package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.context.modifier.MaiaExtension
import ru.agentlab.maia.context.modifier.MaiaRootContextModifier
import ru.agentlab.maia.execution.action.annotated.AnnotatedAction
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.execution.node.ExecutionInput
import ru.agentlab.maia.execution.IExecutionService

class Activator implements BundleActivator {

	extension MaiaExtension = new MaiaExtension

	static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext ctx) throws Exception {
		context = ctx
		val rootContextRef = context.getServiceReference(IMaiaContext)

		val root = context.getService(rootContextRef) => [
			deploy(MaiaRootContextModifier)
		]

		val container = root.createContainer => [
			set("debugString", "container1")
		]
		val container2 = root.createContainer => [
			set("debugString", "container2")
		]
		val container3 = root.createContainer => [
			set("debugString", "container3")
		]

		val agent = container.createAgent => [
			deploy(AgentExample)
			set("debugString", "agent1")
			get(IExecutionNode).addInput(new ExecutionInput("text", String))
		]
//		container.createAgent
//		container.createAgent
//		container.createAgent
//		container.createAgent
		val behaviour = agent.createBehaviour => [
			set("debugString", "behaviour1")
			val action = new AnnotatedAction(PrintlnAction)
			deploy(action, IExecutionNode)
			val input = action.getInput("input")
			if (input != null) {
				set("key", "WORKS")
				input.key = "key"
			}
		]
		agent.createBehaviour => [
			set("debugString", "behaviour2")
			val action = new AnnotatedAction(PrintlnAction)
			deploy(action, IExecutionNode)
			val input = action.getInput("input")
			if (input != null) {
				set("key", "WORKS2")
				input.key = "key"
			}
		]
//		agent.createBehaviour => [
//			deploy(new AnnotatedAction(PrintlnAction), IExecutionNode)
//			set("debugString", "behaviour3")
//		]
//		agent.createBehaviour => [
//			deploy(new AnnotatedAction(PrintlnAction), IExecutionNode)
//			set("debugString", "behaviour4")
//		]
		container.get(IExecutionService).start
	// Thread.sleep(100)
	// container.get(IMaiaExecutorService).stop
//		agent => [
//			get(IMaiaContextLifecycleService).state = FipaLifecycleScheme.STATE_ACTIVE
//
//		]
//		LOGGER.info("CREATE BEHAVIOUR2...")
//		val behaviour2 = agent.get(IMaiaBehaviourContextFactory).createBehaviour(null)
//		LOGGER.info(behaviour.dump)
//
//		LOGGER.info("CREATE CONTAINER FACTORY...")
//		val containerFactory = serviceManager.createService(osgiContext, IContainerFactory)
//
//
//		LOGGER.info("CREATE AGENT...")
//		val agent = agentFactory.createAgent(container)
//		LOGGER.info(agent.dump)
//		agent.get(IMaiaContextInitializerService).addInitializer(agent, AgentExample)
//		LOGGER.info(agent.dump)
//		platformFactory.createDefault(null) => [
//			get(IContainerFactory) => [
//				LOGGER.info("CREATE container1")
//				createDefault(null) => [
//					get(IAgentFactory) => [
//						LOGGER.info("CREATE agent1")
//						createDefault(null) => [
//							LOGGER.info("ADD contributor for agent1")
//							get(IInitializerService).addInitializer(AgentExample)
//							LOGGER.info("INVOKE agent1")
//							get(ILifecycleService).invokeTransition = "INVOKE"
//						]
//					]
//				]
//				LOGGER.info("CREATE container2")
//				createDefault("Container2")
//			]
//		]
//		LOGGER.info("CREATE agent2")
//		val agent2 = agentFactory.createDefault(null, "Agent2")
//		LOGGER.info("INVOKE agent2")
//		agentLyfecycleService.invoke(agent2)
//		Thread.sleep(5000)
//		
//		LOGGER.info("Change Scheduler")
//		val sch = schedulerFactory.create(agent1)
//		val port = Integer.parseInt(System.getProperty("port", "8899"))
//		if(port == 8888){
//			val behaviour = behaviourFactory.createOneShot(agent1, "beh")
//			contributionService.addContributor(behaviour, BehaviourExample2)
//		}
//		
//		Thread.sleep(3000)
//		LOGGER.info("SUSPEND agent1")
//		agentLyfecycleService.suspend(agent1)
//
//		Thread.sleep(3000)
//		LOGGER.info("RESUME agent1")
//		agentLyfecycleService.resume(agent1)
//
//		Thread.sleep(3000)
//		LOGGER.info("SUSPEND agent2")
//		agentLyfecycleService.suspend(agent2)
//
//		Thread.sleep(3000)
//		LOGGER.info("RESUME agent2")
//		agentLyfecycleService.resume(agent2)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

}
