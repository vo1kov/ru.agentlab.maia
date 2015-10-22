package ru.agentlab.maia.task.sequential.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.HashMap
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITaskAdapter
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

class JsonSequentialTaskSchedulerAdapter implements ITaskAdapter<String> {

	val static Configuration conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

	def boolean is(String json) {
		try {
			val String type = JsonPath.using(conf).parse(json).read("$.type")
			return type.equals(SequentialTaskScheduler.name)
		} catch (Exception e) {
			return false
		}
	}

	override ITaskScheduler adapt(String json) {
		val parametersCache = new HashMap<String, ITaskParameter<?>>
		val doc = JsonPath.using(conf).parse(json)
		val String schedulerUuid = doc.read("$.uuid")
		val String schedulerLabel = doc.read("$.label")
		val List<Map<String, String>> schedulerExceptions = doc.read("$.exceptions")
		val List<Map<String, String>> schedulerInputs = doc.read("$.inputs")
		val List<Map<String, String>> schedulerOutputs = doc.read("$.outputs")
		val List<Map<String, String>> schedulerStates = doc.read("$.states")
		return new SequentialTaskScheduler(schedulerUuid) => [ scheduler |
			scheduler.label = schedulerLabel
			schedulerExceptions.forEach [
				val exceptionUuid = get("uuid")
				val exceptionLabel = get("label")
				val exceptionType = get("type")
				scheduler.addException(new TaskException(exceptionLabel))
			]
			schedulerInputs.forEach [
				val inputUuid = get("uuid")
				val inputLabel = get("label")
				val inputType = get("type")
				val javaType = Class.forName(inputType)
				val input = new TaskParameter(inputLabel, javaType)
				scheduler.addInput(input)
				parametersCache.put(inputUuid, input)
			]
			schedulerOutputs.forEach [
				val outputUuid = get("uuid")
				val outputLabel = get("label")
				val outputType = get("type")
				val javaType = Class.forName(outputType)
				val output = new TaskParameter(outputLabel, javaType)
				scheduler.addOutput(output)
				parametersCache.put(outputUuid, output)
			]
			schedulerStates.forEach[]
		]
	}

}