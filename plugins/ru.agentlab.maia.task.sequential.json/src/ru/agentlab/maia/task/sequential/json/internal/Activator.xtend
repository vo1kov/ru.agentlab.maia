package ru.agentlab.maia.task.sequential.json.internal

import java.util.Hashtable
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.task.ITaskAdapter
import ru.agentlab.maia.task.sequential.json.JsonSequentialTaskSchedulerAdapter

class Activator implements BundleActivator {
	
	override start(BundleContext context) throws Exception {
		val dictionary = new Hashtable => [
			
		]
		context.registerService(ITaskAdapter, new JsonSequentialTaskSchedulerAdapter, dictionary)
	}
	
	override stop(BundleContext context) throws Exception {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}