package ru.agentlab.maia.task

import org.osgi.framework.BundleContext
import org.osgi.util.tracker.ServiceTracker
import org.osgi.framework.ServiceReference

class TaskAdapterTracker extends ServiceTracker<ITaskAdapter<?>, ITaskAdapter<?>> {

	val ITaskAdapterRegistry registry

	new(BundleContext context, ITaskAdapterRegistry registry) {
		super(context, ITaskAdapter.name, null)
		this.registry = registry
	}
	
	override addingService(ServiceReference<ITaskAdapter<?>> reference) {
		val adapter = context.getService(reference)
		println("Added adapter" + adapter)
		if (registry != null) {
//			registry.putAdapter(adapter.type, adapter)
		}
		return adapter
	}
	
	override removedService(ServiceReference<ITaskAdapter<?>> reference, ITaskAdapter<?> service) {
		println("Remove adapter" + service)
//		registry.removeAdapter(service.type)
		super.removedService(reference, service)
	}

}