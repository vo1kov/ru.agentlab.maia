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
		val scheduler = adapter.adapt(json)
		assertThat(scheduler, notNullValue)
		assertThat(scheduler.inputs, iterableWithSize(2))
		assertThat(scheduler.outputs, iterableWithSize(1))
		val input1 = scheduler.inputs.get(0)
		assertThat(input1, notNullValue)
		assertThat(input1.name, equalTo("login"))
		assertThat(input1.type, equalTo(String))
		val input2 = scheduler.inputs.get(1)
		assertThat(input2, notNullValue)
		assertThat(input2.name, equalTo("password"))
		assertThat(input2.type, equalTo(String))
		val output1 = scheduler.outputs.get(0)
		assertThat(output1, notNullValue)
		assertThat(output1.name, equalTo("success"))
		assertThat(output1.type, equalTo(Boolean))
	}

	def static void main(String[] args) {
		val test = new JsonTest
		test.test
	}

}