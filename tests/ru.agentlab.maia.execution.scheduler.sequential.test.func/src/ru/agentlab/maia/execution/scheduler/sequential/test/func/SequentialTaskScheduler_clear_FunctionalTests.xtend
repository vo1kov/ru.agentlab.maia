package ru.agentlab.maia.execution.scheduler.sequential.test.func

import org.junit.Test
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequentialTaskScheduler_clear_FunctionalTests {

	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void getSubtasks_returnEmptyIterable_afterClear() {
		val size = 10
		for (i : 0 ..< size) {
			val action = mock(ITask)
			scheduler.addSubtask(action)
		}

		scheduler.clear

		assertThat(scheduler.subtasks, emptyIterable)
	}

	@Test(expected=IllegalStateException)
	def void execute_throw_afterClear() {
		scheduler.clear
		scheduler.execute
	}

}