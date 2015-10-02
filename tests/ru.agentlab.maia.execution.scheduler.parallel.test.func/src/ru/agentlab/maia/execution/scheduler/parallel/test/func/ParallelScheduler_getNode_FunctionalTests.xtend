package ru.agentlab.maia.execution.scheduler.parallel.test.func

import org.junit.Test
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionNode.State
import ru.agentlab.maia.execution.scheduler.parallel.ParallelScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new ParallelScheduler

	def IExecutionNode getSuccessNode() {
		val result = mock(IExecutionNode) => [
			when(it.state).thenReturn(IExecutionNode.State.SUCCESS)

			doAnswer[
				scheduler.notifyChildSuccess
				return null
			].when(it).run
		]
		return result
	}

	def IExecutionNode getFailedNode() {
		val result = mock(IExecutionNode) => [
			when(it.state).thenReturn(IExecutionNode.State.FAILED)

			doAnswer[
				scheduler.notifyChildFailed
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
		scheduler.addChild(successNode)
		scheduler.addChild(failedNode)

		scheduler.run
		scheduler.run

		assertThat(scheduler.state, equalTo(State.FAILED))
	}

}