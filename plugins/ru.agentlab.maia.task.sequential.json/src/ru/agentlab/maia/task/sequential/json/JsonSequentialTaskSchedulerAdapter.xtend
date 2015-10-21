package ru.agentlab.maia.task.sequential.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

class JsonSequentialTaskSchedulerAdapter {

	val PATH_TASK_ID = "$.id"

	val PATH_TASK_LABEL = "$.label"

	val PATH_TASK_EXCEPTIONS = "$.exceptions"

	val PATH_TASK_INPUTS = "$.inputs"

	val PATH_TASK_OUTPUTS = "$.outputs"

	val PATH_TASK_STATES = "$.states"

	val PATH_PARAM_ID = "id"

	val PATH_PARAM_TYPE = "type"
	
	val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	def ITaskScheduler create(String json) {
		val doc = JsonPath.using(conf).parse(json)
		val String id = doc.read(PATH_TASK_ID)
		val String label = doc.read(PATH_TASK_LABEL)
		val List<Map<String, String>> exceptions = doc.read(PATH_TASK_EXCEPTIONS)
		val List<Map<String, String>> inputs = doc.read(PATH_TASK_INPUTS)
		val List<Map<String, String>> outputs = doc.read(PATH_TASK_OUTPUTS)
		val List<Map<String, String>> states = doc.read(PATH_TASK_STATES)
		return new SequentialTaskScheduler(id) => [ scheduler |
			scheduler.label = label
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
		]
	}
}