package ru.agentlab.maia.task.sequential.json.test.blackbox

import org.junit.Test
import ru.agentlab.maia.task.sequential.json.JsonSequentialTaskSchedulerAdapter

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

class JsonTest {

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

	@Test
	def void test() {
		val adapter = new JsonSequentialTaskSchedulerAdapter
		val scheduler = adapter.create(json)
		assertThat(scheduler, notNullValue)
		assertThat(scheduler.inputs, iterableWithSize(2))
		assertThat(scheduler.outputs, iterableWithSize(1))
		assertThat(scheduler.inputs.get(0), notNullValue)
		assertThat(scheduler.inputs.get(0).name, equalTo("login"))
		assertThat(scheduler.inputs.get(0).type, equalTo(String))
		assertThat(scheduler.inputs.get(1), notNullValue)
		assertThat(scheduler.inputs.get(1).name, equalTo("password"))
		assertThat(scheduler.inputs.get(1).type, equalTo(String))
		assertThat(scheduler.outputs.get(0), notNullValue)
		assertThat(scheduler.outputs.get(0).name, equalTo("success"))
		assertThat(scheduler.outputs.get(0).type, equalTo(Boolean))
	}

	def static void main(String[] args) {
		val test = new JsonTest
		test.test
	}

}