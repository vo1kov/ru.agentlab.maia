package ru.agentlab.maia.task.test.integration

import java.util.ArrayList
import java.util.HashMap
import java.util.List
import java.util.Map
import org.hamcrest.Matchers
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import org.mockito.InOrder
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.annotation.Action
import ru.agentlab.maia.task.parallel.ParallelTaskScheduler
import ru.agentlab.maia.task.primitive.AnnotatedAction
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.junit.Assert.*
import static org.mockito.Mockito.*

class Main {

	val Map<String, ITask> cache = new HashMap

	var InOrder inOrder

	@Given("a sequential schedulers $ids")
	def void givenSequentialScheduler(List<String> ids) {
		ids.forEach [
			cache.put(it, new SequentialTaskScheduler)
		]
	}

	@Given("a parallel schedulers $ids")
	def void givenParallelScheduler(List<String> ids) {
		ids.forEach [
			cache.put(it, new ParallelTaskScheduler)
		]
	}

	@Given("a primitive tasks $ids")
	def void givenPrimitiveTask(List<String> ids) {
		val primitives = new ArrayList
		ids.forEach [
			val primitive = spy(new AnnotatedAction(new DummyAction))
			cache.put(it, primitive)
			primitives += primitive
		]
		inOrder = inOrder(primitives.toArray)
	}

	@Given("task $id have subtasks $ids")
	def void givenTaskHaveSubtasks(String id, List<String> ids) {
		val scheduler = cache.get(id) as ITaskScheduler
		ids.forEach [
			scheduler.addSubtask(cache.get(it))
		]
	}

	@When("execute task $id by $times times")
	def void whenExecuteTaskByTimes(String id, int times) {
		val task = cache.get(id)
		for (i : 0 ..< times) {
			task.execute
		}
	}

	@Then("execution order is $ids")
	def void thenExecutionOrderIs(List<String> ids) {
		ids.forEach [
			inOrder.verify(cache.get(it)).execute
		]
	}

	@Then("task $id have $state state")
	def void thenTaskHaveState(String id, String state) {
		assertThat(cache.get(id).state, Matchers.equalTo(State.valueOf(state)))
	}

}

class DummyAction {

	@Action
	def void action() {
	}
}