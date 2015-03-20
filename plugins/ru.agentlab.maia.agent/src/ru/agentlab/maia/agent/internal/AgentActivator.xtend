package ru.agentlab.maia.agent.internal

import javax.annotation.PostConstruct
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.internal.contexts.osgi.EclipseContextOSGi
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.agent.IAgentLifecycleService

class AgentActivator implements BundleActivator {

	static BundleContext context

	def static package BundleContext getContext() {
		return context
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.osgi.framework.BundleActivator#start(org.osgi.framework.BundleContext
	 * )
	 */
	override void start(BundleContext bundleContext) throws Exception {
		AgentActivator.context = bundleContext
		var EclipseContextOSGi osgiContext = new EclipseContextOSGi(context)
		val service = ContextInjectionFactory.make(AgentLifecycleService, osgiContext)
		
		try {
			ContextInjectionFactory.invoke(service, PostConstruct, osgiContext)
		} catch(Exception e){
			//
		}
		
		context.registerService(IAgentLifecycleService, service, null)
		
//		var Agent obj = ContextInjectionFactory.make(Agent, context)
//		ContextInjectionFactory.invoke(obj, PostConstruct, context)
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * org.osgi.framework.BundleActivator#stop(org.osgi.framework.BundleContext)
	 */
	override void stop(BundleContext bundleContext) throws Exception {
		AgentActivator.context = null
	}

}
