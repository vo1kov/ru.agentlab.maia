package ru.agentlab.maia.behaviour.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.behaviour.IBehaviourRegistry
import ru.agentlab.maia.behaviour.BehaviourRegistry

class Activator implements BundleActivator {

	var ServiceRegistration<IBehaviourRegistry> registration

	override start(BundleContext context) throws Exception {
		registration = context.registerService(IBehaviourRegistry, new BehaviourRegistry, null)
	}

	override stop(BundleContext context) throws Exception {
		registration.unregister
	}

}