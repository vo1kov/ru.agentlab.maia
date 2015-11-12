package ru.agentlab.maia.task.sequential.json.test.blackbox.dummy

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.BehaviourParameter
import ru.agentlab.maia.behaviour.IBehaviourScheduler
import ru.agentlab.maia.behaviour.sequential.SequentialBehaviour

class DummyJson2 {

	@Accessors
	val json = '''
		{
			"type" : "ru.agentlab.maia.task.sequential.SequentialTaskScheduler",
			"id" : "6058416d-401c-48e2-bf58-a77d618eb4d2",
			"label" : "ZipatoAuthenticateProtocol",
			"exceptions" : [
				{ "id" : "java.lang.NullPointerException" }
			],
			"inputs" : [
				{ "id" : "login", 		"type" : "java.lang.String" },
				{ "id" : "password", 	"type" : "java.lang.String" }
			],
			"outputs" : [
				{ "id" : "success", "type" : "java.lang.Boolean" }
			]
		}
	'''

	def IBehaviourScheduler getEthalon() {
		return new SequentialBehaviour => [
			addInput(new BehaviourParameter("login", String))
			addInput(new BehaviourParameter("password", String))
			addOutput(new BehaviourParameter("success", Boolean))
		]
	}

}	