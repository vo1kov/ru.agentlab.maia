package ru.agentlab.maia.task.sequential.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.ITaskAdapter

class JsonSequentialTaskSchedulerAdapter implements ITaskAdapter<String>{

	val static String PATH_TASK_ID = "$.id"

	val static String PATH_TASK_LABEL = "$.label"

	val static String PATH_TASK_EXCEPTIONS = "$.exceptions"

	val static String PATH_TASK_INPUTS = "$.inputs"

	val static String PATH_TASK_OUTPUTS = "$.outputs"

	val static String PATH_TASK_STATES = "$.states"

	val static String PATH_PARAM_ID = "id"

	val static String PATH_PARAM_TYPE = "type"
	
	val static Configuration conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	override ITaskScheduler adapt(String json) {
		val doc = JsonPath.using(conf).parse(json)
		val String id = doc.read(PATH_TASK_ID)
		val String label = doc.read(PATH_TASK_LABEL)
		val List<Map<String, String>> exceptions = doc.read(PATH_TASK_EXCEPTIONS)
		val List<Map<String, String>> inputs = doc.read(PATH_TASK_INPUTS)
		val List<Map<String, String>> outputs = doc.read(PATH_TASK_OUTPUTS)
		val List<Map<String, String>> states = doc.read(PATH_TASK_STATES)
		return new SequentialTaskScheduler(id) => [ scheduler |
			scheduler.label = label
			exceptions.forEach[
				val name = get("id")
				scheduler.addException(new TaskException(name))
			]
			inputs.forEach [
				val paramId = get(PATH_PARAM_ID)
				val paramType = get(PATH_PARAM_TYPE)
				val javaType = Class.forName(paramType)
				scheduler.addInput(new TaskParameter(paramId, javaType))
			]
			outputs.forEach [
				val paramId = get(PATH_PARAM_ID)
				val paramType = get(PATH_PARAM_TYPE)
				val javaType = Class.forName(paramType)
				scheduler.addOutput(new TaskParameter(paramId, javaType))
			]
			states.forEach [
				
			]
		]
	}
	
	override getType() {
		return SequentialTaskScheduler.name
	}
	
}