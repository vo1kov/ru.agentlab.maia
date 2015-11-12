package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.adapter.IAdapter
import ru.agentlab.maia.task.adapter.json.internal.Activator
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourModifier
import ru.agentlab.maia.behaviour.IBehaviourRegistry
import ru.agentlab.maia.behaviour.BehaviourModifier

class JsonTaskAdapter implements IAdapter<String, IBehaviour> {

	val public static String JSON = "json"

	var IBehaviourRegistry registry

	@Inject
	new(IBehaviourRegistry registry) {
		this.registry = registry
	}

	override IBehaviour adapt(String json) {
		val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)
		val parsed = JsonPath.using(conf).parse(json).read("$") as Map<String, ?>
		val uuid = parsed.get(BehaviourModifier.TASK_UUID) as String
		val typeString = parsed.get(BehaviourModifier.TASK_TYPE) as String
		var type = Class.forName(typeString) as Class<? extends IBehaviour>
		var task = getTask(uuid, type)
		val modifier = getModifier(type.name)
		if (modifier != null) {
			modifier.modify(task, parsed)
		}
		return task
	}

	/**
	 * <p>Retrieve {@code ITask} object by UUID. If {@code ITaskRegistry} have no 
	 * registered task with specified UUID then new task will be created and registered.</p>
	 * 
	 * @param uuid					unique id of ITask object
	 * @param type					type of ITask object
	 * @return 						ITask object registered in ITaskRegistry with UUID
	 */
	def protected IBehaviour getTask(String uuid, Class<? extends IBehaviour> type) {
		var task = registry.get(uuid)
		if (task == null || !type.isAssignableFrom(task.class)) {
			task = type.newInstance
			registry.put(uuid, task)
		}
		return task
	}

	/**
	 * <p>Retrieve registered {@code ITaskModifier} by language and {@code ITask} type.</p>
	 * 
	 * @param language				language of registered modifier, e.g. json, xml, jade...
	 * @param type					type name of task.
	 * @return 						task modifier for specified language ant task type. 
	 */
	def protected IBehaviourModifier getModifier(String type) {
		val refs = Activator.context.getServiceReferences(
			IBehaviourModifier,
			'''(«IBehaviourModifier.KEY_TYPE»=«type»)'''
		)
		if (!refs.empty) {
			return Activator.context.getService(refs.get(0))
		} else {
			return null
		}
	}
}