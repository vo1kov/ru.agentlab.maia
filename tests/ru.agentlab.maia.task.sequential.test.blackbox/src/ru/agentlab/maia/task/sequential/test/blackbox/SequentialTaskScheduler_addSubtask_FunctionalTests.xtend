package ru.agentlab.maia.task.sequential.test.blackbox

import org.junit.Test
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_addSubtask_FunctionalTests {

	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void getSubtasks_increaseSize_afterAddSubtask() {
		val sizeBefore = scheduler.subtasks.size

		scheduler.addSubtask(mock(ITask))

		assertThat(scheduler.subtasks.size - sizeBefore, equalTo(1))
	}

	@Test
	def void getSubtasks_containsAddedInLast_afterAddSubtask() {
		val task = mock(ITask)

		scheduler.addSubtask(task)

		assertThat(scheduler.subtasks.last, equalTo(task))
	}

	@Test
	def void getSubtasks_notChangeSize_afterAddNullSubtaskAndCatchNPE() {
		val sizeBefore = scheduler.subtasks.size

		try {
			scheduler.addSubtask(null)
		} catch (NullPointerException e) {
		}

		assertThat(scheduler.subtasks.size, equalTo(sizeBefore))
	}

	@Test(expected=NullPointerException)
	def void getSubtasks_throws_afterAddNullSubtask() {
		scheduler.addSubtask(null)
	}

	@Test
	def void getSubtasks_returnAddOrder_afterAddSubtask() {
		val size = 10
		scheduler.clear
		val ITask[] cache = newArrayOfSize(size)
		for (i : 0 ..< size) {
			cache.set(i, mock(ITask))
		}

		for (i : 0 ..< size) {
			val subtask = cache.get(i)
			scheduler.addSubtask(subtask)
		}

		assertThat(scheduler.subtasks, contains(cache))
	}

	@Test
	def void getSubtasks_returnUniqueOnly_afterAddExistingSubtask() {
		val size = 10
		scheduler.clear
		val ITask[] cache = newArrayOfSize(size)
		for (i : 0 ..< size) {
			cache.set(i, mock(ITask))
		}

		for (i : 0 ..< size) {
			val subtask = cache.get(i)
			scheduler.addSubtask(subtask)
			scheduler.addSubtask(subtask)
			scheduler.addSubtask(subtask)
		}

		assertThat(scheduler.subtasks, contains(cache))
	}

	@Test(expected=NullPointerException)
	def void addSubtask_throw_afterAddNullSubtask() {
		scheduler.removeSubtask(null)
	}

	@Test
	def void addSubtask_returnTrue_afterAddNonExistingSubtask() {
		scheduler.clear

		scheduler.addSubtask(mock(ITask))
		val result = scheduler.addSubtask(mock(ITask))

		assertThat(result, equalTo(true))
	}

	@Test
	def void addSubtask_returnFalse_afterAddExistingSubtask() {
		scheduler.clear
		val task = mock(ITask)

		scheduler.addSubtask(task)
		val result = scheduler.addSubtask(task)

		assertThat(result, equalTo(false))
	}

}
