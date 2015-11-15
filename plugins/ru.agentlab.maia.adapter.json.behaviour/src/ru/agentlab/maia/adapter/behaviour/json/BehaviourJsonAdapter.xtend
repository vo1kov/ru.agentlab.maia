package ru.agentlab.maia.adapter.behaviour.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.Map
import java.util.UUID
import ru.agentlab.maia.adapter.Adapter
import ru.agentlab.maia.behaviour.IBehaviour

class BehaviourJsonAdapter extends Adapter<String, IBehaviour> {

	val public static String KEY_UUID = "uuid"

	val public static String KEY_TYPE = "type"

	val public static String LANGUAGE = "behaviour-json"

	val public static String ROOT = "$"

	val Map<UUID, IBehaviour> registry

	new(Map<UUID, IBehaviour> registry) {
		this.registry = registry
	}

	override adapt(String json) {
		val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)
		val parsed = JsonPath.using(conf).parse(json).read(ROOT) as Map<String, ?>
		val uuid = UUID.fromString(parsed.get(KEY_UUID) as String)
		val typeString = parsed.get(KEY_TYPE) as String
		var type = Class.forName(typeString) as Class<? extends IBehaviour>
		var result = getTarget(uuid, type)
		val modifier = getModifier(LANGUAGE, type.name)
		if (modifier != null) {
			modifier.modify(result, parsed)
		}
		return result
	}

	/**
	 * <p>Retrieve target object to be modified by UUID. If registry have no 
	 * registered target object with specified UUID then new object
	 * will be created and registered in registry.</p>
	 * 
	 * @param uuid					unique id of target object
	 * @param type					type of target object
	 * @return 						target object registered in registry with UUID
	 */
	def protected IBehaviour getTarget(UUID uuid, Class<? extends IBehaviour> type) {
		var task = registry.get(uuid)
		if (task == null || !type.isAssignableFrom(task.class)) {
			task = type.newInstance
			registry.put(uuid, task)
		}
		return task
	}

}