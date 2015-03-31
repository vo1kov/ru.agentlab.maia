package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.context.IContributionService
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.platform.IPlatformFactory

class Activator implements BundleActivator {

	val static LOGGER = LoggerFactory.getLogger(Activator)

	static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext

		val platformFactory = context.getService(context.getServiceReference(IPlatformFactory))

		LOGGER.info("CREATE platform")
		platformFactory.createDefault("Platform1") => [
			get(IContainerFactory) => [
				LOGGER.info("CREATE container1")
				createDefault("Container1") => [
					get(IAgentFactory) => [
						LOGGER.info("CREATE agent1")
						createDefault("Agent1") => [
							LOGGER.info("ADD contributor for agent1")
							get(IContributionService).addContributor(AgentExample)
							LOGGER.info("INVOKE agent1")
							get(ILifecycleService).invokeTransition = "INVOKE"
						]
					]
				]
				LOGGER.info("CREATE container2")
				createDefault("Container2")
			]
		]

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
