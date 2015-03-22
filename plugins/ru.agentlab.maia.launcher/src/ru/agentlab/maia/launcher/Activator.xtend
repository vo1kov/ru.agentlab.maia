package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.container.IContainerFactory
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

		LOGGER.info("Create platform")
		val platform1 = platformFactory.create("Platform1", null)

		LOGGER.info("Create container1")
		val container1 = containerFactory.create(platform1, "Container1", null)

		LOGGER.info("Create agent1")
		val agent1 = agentFactory.create(container1, "TestAget1", AgentExample)

		LOGGER.info("Create agent2")
		val agent2 = agentFactory.create(container1, null, AgentExample)

		Thread.sleep(3000)
		LOGGER.info("STOP1")
		agent1.stop
		Thread.sleep(3000)
		LOGGER.info("WOKE UP1")
		agent1.resume
		Thread.sleep(3000)
		LOGGER.info("STOP2")
		agent2.stop
		Thread.sleep(3000)
		LOGGER.info("WOKE UP2")
		agent2.resume
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

}
