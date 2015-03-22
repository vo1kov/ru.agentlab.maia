package ru.agentlab.maia.launcher

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IAgentFactory

class Activator implements BundleActivator {
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
		val agent1 = createAgent(null)
		val agent2 = createAgent("TestAget2")
		Thread.sleep(3000)
		println("STOP1")
		agent1.stop
		Thread.sleep(3000)
		println("WOKE UP1")
		agent1.resume
		Thread.sleep(3000)
		println("STOP2")
		agent2.stop
		Thread.sleep(3000)
		println("WOKE UP2")
		agent2.resume
	}
	
	def IAgent createAgent(String name) {
		println("Create agent " + name)
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
