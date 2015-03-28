package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.container.IContainerFactory
import ru.agentlab.maia.lifecycle.fipa.IFipaAgentLifecycleService
import ru.agentlab.maia.platform.IPlatformFactory

class Activator implements BundleActivator {

	val static LOGGER = LoggerFactory.getLogger(Activator)

	static BundleContext context

	var IPlatformFactory platformFactory
	var IContainerFactory containerFactory
	var IAgentFactory agentFactory

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#start(org.osgi.framework.BundleContext)
	 */
	override void start(BundleContext bundleContext) throws Exception {
		Activator.context = bundleContext

		platformFactory = context.getService(context.getServiceReference(IPlatformFactory))
		containerFactory = context.getService(context.getServiceReference(IContainerFactory))
		agentFactory = context.getService(context.getServiceReference(IAgentFactory))
//		val behaviourFactory = context.getService(context.getServiceReference(IBehaviourFactory))
		val agentLyfecycleService = context.getService(context.getServiceReference(IFipaAgentLifecycleService))

		LOGGER.info("CREATE platform")
		val platform1 = platformFactory.createDefault(null, "Platform1")

		LOGGER.info("CREATE ams agent")
		val amsAgnet = agentFactory.createDefault(platform1, "ams") => [
			agentLyfecycleService.invoke(it)
		]

		LOGGER.info("CREATE container1")
		val container1 = containerFactory.createDefault(platform1, "Container1")

		LOGGER.info("CREATE agent1")
		val agent1 = agentFactory.createDefault(container1, "Agent1")

		LOGGER.info("CREATE agent2")
		val agent2 = agentFactory.createDefault(container1, "Agent2")

		LOGGER.info("INVOKE agent1")
		agentLyfecycleService.invoke(agent1)
//		
//		val port = Integer.parseInt(System.getProperty("port", "8899"))
//		if(port == 8888){
//			behaviourFactory.create(agent2, "beh", BehaviourExample2)
//			
		Thread.sleep(5000)
		LOGGER.info("INVOKE agent2")
		agentLyfecycleService.invoke(agent2)
//		}
//		
		Thread.sleep(3000)
		LOGGER.info("SUSPEND agent1")
		agentLyfecycleService.suspend(agent1)

		Thread.sleep(3000)
		LOGGER.info("RESUME agent1")
		agentLyfecycleService.resume(agent1)

		Thread.sleep(3000)
		LOGGER.info("SUSPEND agent2")
		agentLyfecycleService.suspend(agent2)

		Thread.sleep(3000)
		LOGGER.info("RESUME agent2")
		agentLyfecycleService.resume(agent2)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

}
