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

	val static String DELIMETER = ","

	val Map<String, ITask> cache = new HashMap

	val List<ITask> primitives = new ArrayList

	var InOrder inOrder

	@Given("a sequential schedulers $ids")
	def void givenSequentialScheduler(String ids) {
		for (subtaskId : ids.split(DELIMETER)) {
			val scheduler = new SequentialTaskScheduler
			cache.put(subtaskId.trim, scheduler)
		}
	}

	@Given("a parallel schedulers $ids")
	def void givenParallelScheduler(String ids) {
		for (subtaskId : ids.split(DELIMETER)) {
			val scheduler = new ParallelTaskScheduler
			cache.put(subtaskId.trim, scheduler)
		}
	}

	@Given("a primitive tasks $ids")
	def void givenPrimitiveTask(String ids) {
		for (subtaskId : ids.split(DELIMETER)) {
			val primitive = mock(ITask)
			doAnswer[
				println("EXECUTE " + subtaskId.trim)
				primitive.parent.notifySubtaskSuccess
				return null
			].when(primitive).execute
			cache.put(subtaskId.trim, primitive)
			primitives += primitive
		}
		inOrder = inOrder(primitives.toArray)
	}

	@Given("task $id have subtasks $ids")
	def void givenTaskHaveSubtasks(String id, String ids) {
		val scheduler = cache.get(id) as ITaskScheduler
		for (subtaskId : ids.split(DELIMETER)) {
			val subtask = cache.get(subtaskId.trim)
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
	def void thenExecutionOrderIs(String ids) {
		for (subtaskId : ids.split(DELIMETER)) {
			println("test order " + subtaskId.trim)
			val subtask = cache.get(subtaskId.trim)
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