package ru.agentlab.maia.execution.scheduler.sequential.test.func

import org.junit.Test
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_addSubtask_FunctionalTests {

	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void getSubtasks_increaseSize_whenValidArgs() {
		val sizeBefore = scheduler.subtasks.size

		scheduler.addSubtask(mock(ITask))
		val sizeAfter = scheduler.subtasks.size

		assertThat(sizeAfter - sizeBefore, equalTo(1))
	}

	@Test
	def void getSubtasks_containsAddedInLast_whenValidArgs() {
		val task = mock(ITask)

		scheduler.addSubtask(task)

		assertThat(scheduler.subtasks.last, equalTo(task))
	}

	@Test
	def void getSubtasks_notChangeSize_whenCatchNPE() {
		val sizeBefore = scheduler.subtasks.size

		try {
			scheduler.addSubtask(null)
		} catch (NullPointerException e) {
		}
		val sizeAfter = scheduler.subtasks.size

		assertThat(sizeAfter, equalTo(sizeBefore))
	}

	@Test(expected=NullPointerException)
	def void getSubtasks_throws_whenNullArgs() {
		scheduler.addSubtask(null)
	}

	@Test
	def void getSubtasks_returnAddOrder() {
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

		assertThat(scheduler.subtasks, contains(cache.toArray))
	}

	@Test
	def void getSubtasks_returnUniqueOnly_whenAddDublicates() {
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

		assertArrayEquals(cache, scheduler.subtasks.toList.toArray)
	}

	@Test(expected=NullPointerException)
	def void addSubtask_throw_whenNullArgs() {
		scheduler.removeSubtask(null)
	}

	@Test
	def void addSubtask_returnTrue_whenUniqueArg() {
		scheduler.clear

		scheduler.addSubtask(mock(ITask))
		val result = scheduler.addSubtask(mock(ITask))

		assertThat(result, equalTo(true))
	}

	@Test
	def void addSubtask_returnFalse_whenDublicate() {
		scheduler.clear
		val task = mock(ITask)

		scheduler.addSubtask(task)
		val result = scheduler.addSubtask(task)

		assertThat(result, equalTo(false))
	}

}
