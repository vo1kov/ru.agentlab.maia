package ru.agentlab.maia.task.sequential.json.test.blackbox.dummy

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskParameter
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

class DummyJson {
	
	@Accessors
	val json = '''
		{
			"id" : "6058416d-401c-48e2-bf58-a77d618eb4d2",
			"label" : "ZipatoAuthenticateProtocol",
			"inputs" : [
				{ "id" : "login", 		"type" : "java.lang.String" },
				{ "id" : "password", 	"type" : "java.lang.String" }
			],
			"outputs" : [
				{ "id" : "success", "type" : "java.lang.Boolean" }
			]
		}
	'''

	def ITaskScheduler getEthalon() {
		return new SequentialTaskScheduler => [
			addInput(new TaskParameter("login", String))
			addInput(new TaskParameter("password", String))
			addOutput(new TaskParameter("success", Boolean))
		]
	}

}	