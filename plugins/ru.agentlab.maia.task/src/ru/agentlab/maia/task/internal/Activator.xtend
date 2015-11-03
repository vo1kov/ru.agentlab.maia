package ru.agentlab.maia.task.internal

import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.TaskRegistry

class Activator implements BundleActivator {

	var ServiceRegistration<ITaskRegistry> registration

	override start(BundleContext context) throws Exception {
		registration = context.registerService(ITaskRegistry, new TaskRegistry, null)
	}

	override stop(BundleContext context) throws Exception {
		registration.unregister
	}

}