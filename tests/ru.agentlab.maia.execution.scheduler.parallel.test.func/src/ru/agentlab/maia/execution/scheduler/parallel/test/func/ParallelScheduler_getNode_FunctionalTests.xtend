package ru.agentlab.maia.execution.scheduler.parallel.test.func

import org.junit.Test
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionNode.State

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import ru.agentlab.maia.execution.scheduler.parallel.ParallelTaskScheduler

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new ParallelTaskScheduler

	def IExecutionNode getSuccessNode() {
		val result = mock(IExecutionNode) => [
			when(it.state).thenReturn(IExecutionNode.State.SUCCESS)

			doAnswer[
				scheduler.notifySubtaskSuccess
				return null
			].when(it).run
		]
		return result
	}

	def IExecutionNode getFailedNode() {
		val result = mock(IExecutionNode) => [
			when(it.state).thenReturn(IExecutionNode.State.FAILED)

			doAnswer[
				scheduler.notifySubtaskFailed
				return null
			].when(it).run
		]
		return result
	}

	/**
	 * Test if last child FAILED then scheduler should be FAILED
	 */
	@Test
	def void test() {
		scheduler.addSubtask(successNode)
		scheduler.addSubtask(failedNode)

		scheduler.run
		scheduler.run

		assertThat(scheduler.state, equalTo(State.FAILED))
	}

}