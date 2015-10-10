package ru.agentlab.maia.task.sequential.test.blackbox

import java.util.Random
import org.junit.Test
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_execute_FunctionalTests {

	val rnd = new Random

	ITaskScheduler scheduler = spy(new SequentialTaskScheduler)

	@Test(expected=IllegalStateException)
	def void execute_throw_whenNoSubtasks() {
		scheduler.execute
	}

	@Test
	def void execute_invokeFirstSubtask_whenHaveSubtasks() {
		val task = mock(ITask)
		scheduler.addSubtask(task)

		scheduler.execute

		verify(task).execute
	}

	@Test
	def void execute_invokeSubtasksInOrder_whenExecute() {
		val size = 10
		val ITask[] cache = newArrayOfSize(size)
		for (i : 0 ..< size) {
			val task = getSuccessNode()
			cache.set(i, task)
			scheduler.addSubtask(task)
		}
		val inOrder = inOrder(cache)

		for (i : 0 ..< size) {
			scheduler.execute
		}

		for (i : 0 ..< size) {
			inOrder.verify(cache.get(i)).execute
		}
	}

	@Test
	def void getState_returnSuccess_whenAllSubtasksSuccess() {
		val size = 10
		for (i : 0 ..< size) {
			val task = getSuccessNode()
			scheduler.addSubtask(task)
		}

		for (i : 0 ..< size) {
			scheduler.execute
		}

		assertThat(scheduler.state, equalTo(State.SUCCESS))
	}

	@Test
	def void getState_returnFailed_whenSomeSubtaskFailedExecute() {
		val size = 10
		val failedSubtaskIndex = rnd.nextInt(size)
		for (i : 0 ..< size) {
			val task = if (i === failedSubtaskIndex) {
					failedNode
				} else {
					successNode
				}
			scheduler.addSubtask(task)
		}

		for (i : 0 ..< failedSubtaskIndex + 1) {
			scheduler.execute
		}

		assertThat(scheduler.state, equalTo(State.FAILED))
	}

	def private ITask getSuccessNode() {
		val result = mock(ITask) => [
			when(it.state).thenReturn(ITask.State.SUCCESS)

			doAnswer[
				scheduler.notifySubtaskSuccess
				return null
			].when(it).execute
		]
		return result
	}

	def private ITask getFailedNode() {
		val result = mock(ITask) => [
			when(it.state).thenReturn(ITask.State.FAILED)

			doAnswer[
				scheduler.notifySubtaskFailed
				return null
			].when(it).execute
		]
		return result
	}

}