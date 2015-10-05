package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.Random
import org.junit.Test
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_removeSubtask_FunctionalTests {

	val rnd = new Random

	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void getSubtasks_decreaseSize_whenValidArgs() {
		val size = 10
		val sizeBefore = scheduler.subtasks.size
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val toRemoveTask = scheduler.subtasks.get(rnd.nextInt(size))

		scheduler.removeSubtask(toRemoveTask)

		assertThat(scheduler.subtasks.size - sizeBefore, equalTo(-1))
	}

	@Test
	def void getSubtasks_unchangeSize_whenUnknownArgs() {
		val size = 10
		val ITask[] cache = newArrayOfSize(size)
		val sizeBefore = scheduler.subtasks.size
		for (i : 0 ..< size) {
			val action = mock(ITask)
			scheduler.addSubtask(action)
			cache.set(i, action)
		}

		scheduler.removeSubtask(mock(ITask))

		assertThat(scheduler.subtasks.size, equalTo(sizeBefore))
	}

	@Test
	def void getSubtasks_unchangeSize_whenCatchNPE() {
		val size = 10
		val ITask[] cache = newArrayOfSize(size)
		val sizeBefore = scheduler.subtasks.size
		for (i : 0 ..< size) {
			val action = mock(ITask)
			scheduler.addSubtask(action)
			cache.set(i, action)
		}

		try {
			scheduler.removeSubtask(null)
		} catch (NullPointerException e) {
		}

		assertThat(scheduler.subtasks.size, equalTo(sizeBefore))
	}

	@Test
	def void getSubtasks_notContainsRemoved_whenValidArgs() {
		val size = 10
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val removed = scheduler.subtasks.get(rnd.nextInt(size))

		scheduler.removeSubtask(removed)

		assertThat(scheduler.subtasks.findFirst[it === removed] != null, equalTo(false))
	}

	@Test
	def void getSubtasks_unchanged_whenUnknownArgs() {
		val size = 10
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val before = scheduler.subtasks.toList.toArray

		scheduler.removeSubtask(mock(ITask))

		assertArrayEquals(before, scheduler.subtasks.toList.toArray)
	}

	@Test(expected=NullPointerException)
	def void removeSubtask_throw_whenNullArgs() {
		scheduler.addSubtask(mock(ITask))
		scheduler.removeSubtask(null)
	}

	@Test
	def void removeSubtask_returnTrue_whenValidArgs() {
		val task = mock(ITask)
		scheduler.addSubtask(task)

		val result = scheduler.removeSubtask(task)

		assertThat(result, equalTo(true))
	}

	@Test
	def void removeSubtask_returnFalse_whenUnknownArgs() {
		scheduler.addSubtask(mock(ITask))

		val result = scheduler.removeSubtask(mock(ITask))

		assertThat(result, equalTo(false))
	}

}