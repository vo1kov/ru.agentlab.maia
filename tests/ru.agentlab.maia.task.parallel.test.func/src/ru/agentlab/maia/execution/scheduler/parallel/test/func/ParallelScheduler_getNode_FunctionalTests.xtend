package ru.agentlab.maia.execution.scheduler.parallel.test.func

import org.junit.Test
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITask.State
import ru.agentlab.maia.execution.scheduler.parallel.ParallelTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Ignore

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new ParallelTaskScheduler

	def ITask getSuccessNode() {
		val result = mock(ITask) => [
			when(it.state).thenReturn(ITask.State.SUCCESS)

			doAnswer[
				scheduler.notifySubtaskSuccess
				return null
			].when(it).execute
		]
		return result
	}

	def ITask getFailedNode() {
		val result = mock(ITask) => [
			when(it.state).thenReturn(ITask.State.FAILED)

			doAnswer[
				scheduler.notifySubtaskFailed
				return null
			].when(it).execute
		]
		return result
	}

	/**
	 * Test if last child FAILED then scheduler should be FAILED
	 */
	@Test @Ignore
	def void test() {
		scheduler.addSubtask(successNode)
		scheduler.addSubtask(failedNode)

		scheduler.execute
		scheduler.execute

		assertThat(scheduler.state, equalTo(State.FAILED))
	}

}