package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.ArrayList
import java.util.List
import java.util.Map
import org.osgi.framework.BundleContext
import org.osgi.framework.ServiceReference
import org.osgi.util.tracker.ServiceTracker
import ru.agentlab.maia.task.ITaskAdapter

class JsonTaskAdapter extends ServiceTracker<ITaskAdapter<?>, ITaskAdapter<?>> implements ITaskAdapter<String> {
	
	val static Configuration conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)
	
	val List<ITaskAdapter<?>> elements = new ArrayList
	
	new(BundleContext context) {
		super(context, ITaskAdapter.name, null)
	}
	
	override adapt(String json) {
		val doc = JsonPath.using(conf).parse(json)
		val String id = doc.read("$.id")
		val String label = doc.read("$.label")
		val List<Map<String, ?>> exceptions = doc.read("$.exceptions")
		val List<Map<String, ?>> inputs = doc.read("$.inputs")
		val List<Map<String, ?>> outputs = doc.read("$.outputs")
		val List<Map<String, ?>> states = doc.read("$.states")
		null
	}
	
	override addingService(ServiceReference<ITaskAdapter<?>> reference) {
		val adapter = context.getService(reference)
		println("Added adapter" + adapter)
//			registry.putAdapter(adapter.type, adapter)
		return adapter
	}
	
	override removedService(ServiceReference<ITaskAdapter<?>> reference, ITaskAdapter<?> service) {
		println("Remove adapter" + service)
//		registry.removeAdapter(service.type)
		super.removedService(reference, service)
	}
	
}