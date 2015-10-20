package ru.agentlab.maia.task.sequential.json.test.blackbox.dummy

import java.util.List
import ru.agentlab.maia.task.TaskParameter

class DummyJson {

	val json = '''
		{
			"id":"6058416d-401c-48e2-bf58-a77d618eb4d2",
			"label":"ZipatoAuthenticateProtocol",
			"inputs":[
				{  
					"id":"login",
					"type":"java.lang.String"
				},
				{
					"id":"password",
					"type":"java.lang.String"
				}
			],
			"outputs":[
				{
					"id":"success",
					"type":"java.lang.Boolean"
				}
			]
		}
	'''

	def List<TaskParameter<?>> getInputParameters() {
		return #[
			new TaskParameter("login", String),
			new TaskParameter("password", String)
		]
	}

	def List<TaskParameter<?>> getOutputParameters() {
		return #[
			new TaskParameter("success", Boolean)
		]
	}

}	