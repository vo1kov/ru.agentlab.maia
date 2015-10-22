package ru.agentlab.maia.task.sequential.json.internal

import java.util.Hashtable
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceRegistration
import ru.agentlab.maia.task.ITaskAdapter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler
import ru.agentlab.maia.task.sequential.json.JsonSequentialTaskSchedulerAdapter

class Activator implements BundleActivator {

	var ServiceRegistration<?> registration

	override start(BundleContext context) throws Exception {
		val dictionary = new Hashtable => [
			put(ITaskAdapter.KEY_LANGUAGE, "JSON")
			put(ITaskAdapter.KEY_TYPE, SequentialTaskScheduler.name)
		]
		registration = context.registerService(ITaskAdapter, new JsonSequentialTaskSchedulerAdapter, dictionary)
	}

	override stop(BundleContext context) throws Exception {
		context.ungetService(registration.reference)

	}

}