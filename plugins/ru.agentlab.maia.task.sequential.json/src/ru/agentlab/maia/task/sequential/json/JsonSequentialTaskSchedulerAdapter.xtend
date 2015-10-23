package ru.agentlab.maia.task.sequential.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.HashMap
import java.util.List
import java.util.Map
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskAdapter
import ru.agentlab.maia.task.ITaskException
import ru.agentlab.maia.task.ITaskParameter
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskException
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

class JsonSequentialTaskSchedulerAdapter implements ITaskAdapter<String> {

	val protected Configuration conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)

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
		val subtasksCache = new HashMap<String, ITask>
		val exceptionsCache = new HashMap<String, ITaskException>
		val doc = JsonPath.using(conf).parse(json)
		val String schedulerUuid = doc.read("$.uuid")
		val String schedulerLabel = doc.read("$.label")
		val List<Map<String, String>> schedulerExceptions = doc.read("$.exceptions")
		val List<Map<String, String>> schedulerInputs = doc.read("$.inputs")
		val List<Map<String, String>> schedulerOutputs = doc.read("$.outputs")
		val List<Map<String, String>> schedulerSubtasks = doc.read("$.subtasks")
		return new SequentialTaskScheduler(schedulerUuid) => [ scheduler |
			scheduler.label = schedulerLabel
			schedulerExceptions.forEach [
				val exceptionUuid = get("uuid")
				val exceptionLabel = get("label")
//				val exceptionType = get("type")
				val exception = new TaskException(exceptionLabel)
				scheduler.addException(exception)
				exceptionsCache.put(exceptionUuid, exception)
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
			schedulerSubtasks.forEach[]
		]
	}

}