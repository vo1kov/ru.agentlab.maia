package ru.agentlab.maia.task.sequential.test.func

import java.util.Random
import org.junit.Test
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_removeSubtask_FunctionalTests {

	val rnd = new Random

	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void getSubtasks_decreaseSize_afterRemoveExistingSubtask() {
		val size = 10
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val sizeBefore = scheduler.subtasks.size
		val toRemoveTask = scheduler.subtasks.get(rnd.nextInt(size))

		scheduler.removeSubtask(toRemoveTask)

		assertThat(scheduler.subtasks.size - sizeBefore, equalTo(-1))
	}

	@Test
	def void getSubtasks_unchangeSize_afterRemoveNonExistingSubtask() {
		val size = 10
		for (i : 0 ..< size) {
			val action = mock(ITask)
			scheduler.addSubtask(action)
		}
		val sizeBefore = scheduler.subtasks.size

		scheduler.removeSubtask(mock(ITask))

		assertThat(scheduler.subtasks.size, equalTo(sizeBefore))
	}

	def private void givenSchedulerWithSize(int size) {
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
	}

	def private void whenRemoveExistingSubtask() {
		val size = scheduler.subtasks.size
		val task = scheduler.subtasks.get(rnd.nextInt(size))
		scheduler.removeSubtask(task)
	}

	def private void whenRemoveNullSubtask() {
		scheduler.removeSubtask(null)
	}

	def private void whenRemoveNullSubtaskAndCatchException() {
		try {
			scheduler.removeSubtask(null)
		} catch (Exception e) {
		}
	}

	def private void thenSchedulerSizeIs(int size) {
		assertThat(scheduler.subtasks.size, equalTo(size))
	}

	@Test
	def void getSubtasks_unchangeSize_afterRemoveSubtaskAndCatchNPE() {
		val size = 10
		givenSchedulerWithSize(size)

		whenRemoveNullSubtaskAndCatchException()

		thenSchedulerSizeIs(size)
	}

	@Test
	def void getSubtasks_notContainsRemoved_afterRemoveExistingSubtask() {
		val size = 10
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val removed = scheduler.subtasks.get(rnd.nextInt(size))

		scheduler.removeSubtask(removed)

		assertThat(scheduler.subtasks.findFirst[it === removed] != null, equalTo(false))
	}

	@Test
	def void getSubtasks_unchanged_afterRemoveNonExistingSubtask() {
		val size = 10
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
		val before = scheduler.subtasks.toList.toArray

		scheduler.removeSubtask(mock(ITask))

		assertArrayEquals(before, scheduler.subtasks.toList.toArray)
	}

	@Test(expected=NullPointerException)
	def void removeSubtask_throw_afterRemoveNullSubtask() {
		scheduler.addSubtask(mock(ITask))
		scheduler.removeSubtask(null)
	}

	@Test
	def void removeSubtask_returnTrue_afterRemoveExistingSubtask() {
		val task = mock(ITask)
		scheduler.addSubtask(task)

		val result = scheduler.removeSubtask(task)

		assertThat(result, equalTo(true))
	}

	@Test
	def void removeSubtask_returnFalse_afterRemoveNonExistingSubtask() {
		scheduler.addSubtask(mock(ITask))

		val result = scheduler.removeSubtask(mock(ITask))

		assertThat(result, equalTo(false))
	}

}