package ru.agentlab.maia.task.test.integration

import java.util.HashMap
import java.util.List
import java.util.Map
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler
import ru.agentlab.maia.behaviour.parallel.BehaviourSchedulerParallel
import ru.agentlab.maia.behaviour.primitive.BehaviourPrimitiveMethod
import ru.agentlab.maia.behaviour.sequential.BehaviourSchedulerSequential
import ru.agentlab.maia.task.test.integration.doubles.DummyAction

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

class Main {

	val Map<String, IBehaviour> tasks = new HashMap

	val Map<String, DummyAction> impls = new HashMap

	@Given("a sequential schedulers $ids")
	def void givenSequentialScheduler(List<String> ids) {
		ids.forEach [
			tasks.put(it, new BehaviourSchedulerSequential)
		]
	}

	@Given("a parallel schedulers $ids")
	def void givenParallelScheduler(List<String> ids) {
		ids.forEach [
			tasks.put(it, new BehaviourSchedulerParallel)
		]
	}

	@Given("a primitive tasks $ids")
	def void givenPrimitiveBehaviour(List<String> ids) {
		ids.forEach [
			val impl = new DummyAction
			val task = new BehaviourPrimitiveMethod => [
				implementation = impl
			]
			impls.put(it, impl)
			tasks.put(it, task)
		]
	}

	@Given("task $id have subtasks $ids")
	def void givenBehaviourHaveSubtasks(String id, List<String> ids) {
		val scheduler = tasks.get(id) as IBehaviourScheduler
		ids.forEach [
			scheduler.addChild(tasks.get(it))
		]
	}

	@When("execute task $id by $times times")
	def void whenExecuteBehaviourByTimes(String id, int times) {
		val task = tasks.get(id)
		for (i : 0 ..< times) {
			task.execute
		}
	}

	@Then("task $execute have been executed")
	def void thenBehaviourExecuted(String id) {
		if (id != null && !id.empty) {
			assertThat(impls.get(id).count, equalTo(1))
		}
	}

	@Then("task $id have $state state")
	def void thenBehaviourHaveState(String id, String state) {
		assertThat(tasks.get(id).state, equalTo(Behaviour.State.valueOf(state)))
	}

}