package ru.agentlab.maia.task.sequential.internal

import java.util.Hashtable
import org.osgi.framework.BundleActivator
import org.osgi.framework.BundleContext
import ru.agentlab.maia.task.ITaskModifier
import ru.agentlab.maia.task.TaskSchedulerOrdered
import ru.agentlab.maia.task.sequential.SequentialTaskSchedulerModifier

class Activator implements BundleActivator {

	override start(BundleContext context) throws Exception {
		val properties = new Hashtable<String, Object> => [
			put(ITaskModifier.KEY_TYPE, TaskSchedulerOrdered)
		]
		context.registerService(ITaskModifier, new SequentialTaskSchedulerModifier, properties)

	}

	override stop(BundleContext context) throws Exception {
	}

}