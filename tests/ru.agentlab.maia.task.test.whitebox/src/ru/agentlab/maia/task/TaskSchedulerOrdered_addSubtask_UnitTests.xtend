package ru.agentlab.maia.task

import org.mockito.Spy
import ru.agentlab.maia.task.ITask

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class TaskSchedulerOrdered_addSubtask_UnitTests {

	var protected ITask task = createTask()

	@Spy
	var protected TaskSchedulerOrdered scheduler

	def static ITask createTask() {
		return mock(ITask)
	}

	def void before() {
		doCallRealMethod.when(scheduler).internalAddSubtask(task)
	}

	@org.junit.Test
	def void index_notChanged_whenIndexOn0() {
		scheduler.subtasks.clear
		scheduler.index = 0

		scheduler.addSubtask(createTask)

		assertThat(scheduler.index, equalTo(1))
	}

	@org.junit.Test
	def void index_notChanged_whenIndexOnLast() {
		val size = 10
		val lastIndex = size - 1
		scheduler.subtasks => [
			clear
			for (i : 0 ..< size) {
				add(createTask)
			}
		]
		scheduler.index = lastIndex

		scheduler.addSubtask(createTask)

		assertThat(scheduler.index, equalTo(lastIndex))
	}

	@org.junit.Test(expected=NullPointerException)
	def void addSubtask_throw_whenNullArgs() {
		scheduler.addSubtask(task)
	}

}