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
import ru.agentlab.maia.task.parallel.ParallelTaskScheduler
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.junit.Assert.*
import static org.mockito.Mockito.*

class Main {

	val Map<String, ITask> cache = new HashMap

	val List<ITask> primitives = new ArrayList

	var InOrder inOrder

	@Given("a sequential schedulers $ids")
	def void givenSequentialScheduler(List<String> ids) {
		for (subtaskId : ids) {
			val scheduler = new SequentialTaskScheduler
			cache.put(subtaskId, scheduler)
		}
	}

	@Given("a parallel schedulers $ids")
	def void givenParallelScheduler(List<String> ids) {
		for (subtaskId : ids) {
			val scheduler = new ParallelTaskScheduler
			cache.put(subtaskId, scheduler)
		}
	}

	@Given("a primitive tasks $ids")
	def void givenPrimitiveTask(List<String> ids) {
		for (subtaskId : ids) {
			val primitive = mock(ITask)
			doAnswer[
				println("EXECUTE " + subtaskId)
				primitive.parent.notifySubtaskSuccess
				return null
			].when(primitive).execute
			cache.put(subtaskId, primitive)
			primitives += primitive
		}
		inOrder = inOrder(primitives.toArray)
	}

	@Given("task $id have subtasks $ids")
	def void givenTaskHaveSubtasks(String id, List<String> ids) {
		val scheduler = cache.get(id) as ITaskScheduler
		for (subtaskId : ids) {
			val subtask = cache.get(subtaskId)
			scheduler.addSubtask(subtask)
			if (primitives.contains(subtask)) {
				when(subtask.parent).thenReturn(scheduler)
			}
		}
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
		for (subtaskId : ids) {
			println("test order " + subtaskId)
			val subtask = cache.get(subtaskId)
			inOrder.verify(subtask).execute
		}
	}

	@Then("task $id have $state state")
	def void thenTaskHaveState(String id, String state) {
		val task = cache.get(id)
		val s = State.valueOf(state)
		assertThat(task.state, Matchers.equalTo(s))
	}

}