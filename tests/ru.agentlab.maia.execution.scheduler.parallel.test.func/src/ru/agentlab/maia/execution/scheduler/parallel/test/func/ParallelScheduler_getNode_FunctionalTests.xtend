package ru.agentlab.maia.execution.scheduler.parallel.test.func

import org.junit.Test
import ru.agentlab.maia.execution.IExecutionAction
import ru.agentlab.maia.execution.scheduler.parallel.ParallelScheduler

import static org.mockito.Mockito.*
import ru.agentlab.maia.execution.IExecutionNode

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new ParallelScheduler

	@Test
	def void test() {
		val exceptionalChild = mock(IExecutionAction)
		when(exceptionalChild.state)
			.thenReturn(IExecutionNode.READY)
			.thenReturn(IExecutionNode.EXCEPTION)
			
		doAnswer[
			scheduler.notifyChildException
			return null
		].when(exceptionalChild).run

		scheduler.addChild(exceptionalChild)
		scheduler.run
	}

}