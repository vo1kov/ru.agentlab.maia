package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.adapter.ITaskAdapter
import ru.agentlab.maia.task.adapter.ITaskModifier
import ru.agentlab.maia.task.adapter.json.internal.Activator

class JsonTaskAdapter implements ITaskAdapter<String> {

	val static String PATH_ROOT = "$"

	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	var ITaskRegistry registry

	@Inject
	new(ITaskRegistry registry) {
		this.registry = registry
	}

	override ITask adapt(String json) {
		val parsed = JsonPath.using(conf).parse(json).read(PATH_ROOT) as Map<String, ?>
		val uuid = parsed.get(JsonConstants.TASK_UUID) as String
		val typeString = parsed.get(JsonConstants.TASK_TYPE) as String
		var type = Class.forName(typeString) as Class<? extends ITask>
		var task = getTask(uuid, type)
		val modifier = getModifier(JsonConstants.LANGUAGE, type.name) as ITaskModifier<Map<String, ?>>
		if (modifier != null) {
			modifier.modify(task, parsed)
		}
		return task
	}
	
	def protected ITask adapt(Map<String, ?> parsed){
		val uuid = parsed.get(JsonConstants.TASK_UUID) as String
		val typeString = parsed.get(JsonConstants.TASK_TYPE) as String
		var type = Class.forName(typeString) as Class<? extends ITask>
		var task = getTask(uuid, type)
		val modifier = getModifier(JsonConstants.LANGUAGE, type.name) as ITaskModifier<Map<String, ?>>
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
	def protected ITask getTask(String uuid, Class<? extends ITask> type) {
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
	def protected ITaskModifier<?> getModifier(String language, String type) {
		val refs = Activator.context.getServiceReferences(
			ITaskModifier,
			'''(&(«ITaskAdapter.KEY_LANGUAGE»=«language»)(«ITaskModifier.KEY_TYPE»=«type»))'''
		)
		if (!refs.empty) {
			return Activator.context.getService(refs.get(0))
		} else {
			return null
		}
	}
}