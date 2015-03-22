package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentFactory
import ru.agentlab.maia.platform.IPlatformFactory
import org.slf4j.LoggerFactory

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
		
		LOGGER.info("Create platform")
		val ref = context.getServiceReference(IPlatformFactory)
		val service = context.getService(ref)
		service.create("Platform1", null)
		
		
		val agent1 = createAgent("TestAget1")
		val agent2 = createAgent("TestAget2")
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
	
	def IAgent createAgent(String name) {
		LOGGER.info("Create agent " + name)
		val ref = context.getServiceReference(IAgentFactory)
		val service = context.getService(ref)
		service.create(name, AgentExample)
	}

	/*
	 * (non-Javadoc)
	 * @see BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		Activator.context = null
	}

}
