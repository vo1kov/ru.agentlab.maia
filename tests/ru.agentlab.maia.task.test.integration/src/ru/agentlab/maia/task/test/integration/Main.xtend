package ru.agentlab.maia.task.test.integration

import java.util.HashMap
import java.util.List
import java.util.Map
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.annotation.Action
import ru.agentlab.maia.task.parallel.ParallelTaskScheduler
import ru.agentlab.maia.task.primitive.AnnotatedAction
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

class Main {

	val Map<String, ITask> tasks = new HashMap
	
	val Map<String, DummyAction> impls = new HashMap

	@Given("a sequential schedulers $ids")
	def void givenSequentialScheduler(List<String> ids) {
		ids.forEach [
			tasks.put(it, new SequentialTaskScheduler)
		]
	}

	@Given("a parallel schedulers $ids")
	def void givenParallelScheduler(List<String> ids) {
		ids.forEach [
			tasks.put(it, new ParallelTaskScheduler)
		]
	}

	@Given("a primitive tasks $ids")
	def void givenPrimitiveTask(List<String> ids) {
		ids.forEach [
			val impl = new DummyAction
			val task = new AnnotatedAction(impl)
			impls.put(it, impl)
			tasks.put(it, task)
		]
	}

	@Given("task $id have subtasks $ids")
	def void givenTaskHaveSubtasks(String id, List<String> ids) {
		val scheduler = tasks.get(id) as ITaskScheduler
		ids.forEach [
			scheduler.addSubtask(tasks.get(it))
		]
	}

	@When("execute task $id by $times times")
	def void whenExecuteTaskByTimes(String id, int times) {
		val task = tasks.get(id)
		for (i : 0 ..< times) {
			task.execute
		}
	}

	@Then("task $execute have been executed")
	def void thenTaskExecuted(String id) {
		if (id != null && !id.empty) {
			assertThat(impls.get(id).count, equalTo(1))
		}
	}

	@Then("task $id have $state state")
	def void thenTaskHaveState(String id, String state) {
		assertThat(tasks.get(id).state, equalTo(State.valueOf(state)))
	}

}

class DummyAction {

	var protected int count = 0

	@Action
	def void action() {
		count++
	}
}