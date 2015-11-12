package ru.agentlab.maia.task.adapter.json

import com.jayway.jsonpath.Configuration
import com.jayway.jsonpath.JsonPath
import com.jayway.jsonpath.Option
import java.util.ArrayList
import java.util.List
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.adapter.IIssue
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskRegistry
import ru.agentlab.maia.task.TaskModifier
import ru.agentlab.maia.task.issue.SetTaskIssue
import ru.agentlab.maia.task.issue.SetTaskLabelIssue
import ru.agentlab.maia.task.issue.SetTaskExceptionIssue
import ru.agentlab.maia.task.issue.SetTaskInputIssue

class JsonTaskParser {

	var ITaskRegistry registry

	@Inject
	new(ITaskRegistry registry) {
		this.registry = registry
	}

	def List<IIssue> parse(String json) {
		val result = new ArrayList<IIssue>
		val conf = Configuration.defaultConfiguration.addOptions(Option.DEFAULT_PATH_LEAF_TO_NULL)
		val parsed = JsonPath.using(conf).parse(json).read("$") as Map<String, ?>

		val taskUuid = parsed.get(TaskModifier.TASK_UUID) as String
		var taskType = Class.forName(parsed.get(TaskModifier.TASK_TYPE) as String) as Class<? extends ITask>
		result += new SetTaskIssue(taskUuid, taskUuid, taskType)

		val taskLabel = parsed.get("label") as String
		result += new SetTaskLabelIssue(taskUuid, null, taskLabel)

		val exceptions = parsed.get("exceptions") as List<Map<String, String>>
		for (exception : exceptions) {
			val exceptionUuid = exception.get("uuid")
			val exceptionLabel = exception.get("label")
			result += new SetTaskExceptionIssue(taskUuid, exceptionUuid, exceptionLabel)
		}
		
		val inputs = parsed.get("inputs") as List<Map<String, String>>
		for (input : inputs) {
			val inputUuid = input.get("uuid")
			val inputLabel = input.get("label")
			val inputType = Class.forName(input.get("type"))
			result += new SetTaskInputIssue(taskUuid, inputUuid, inputLabel, inputType)
		}
		
		val outputs = parsed.get("outputs") as List<Map<String, String>>
		for (output : outputs) {
			val outputUuid = output.get("uuid")
			val outputLabel = output.get("label")
			val outputType = Class.forName(output.get("type"))
			result += new SetTaskInputIssue(taskUuid, outputUuid, outputLabel, outputType)
		}
		
		return result
	}

}