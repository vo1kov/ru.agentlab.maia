package ru.agentlab.maia.task.parallel.test.blackbox

import org.junit.Ignore
import org.junit.Test
import ru.agentlab.maia.behaviour.BehaviourState
import ru.agentlab.maia.behaviour.IBehaviour

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import ru.agentlab.maia.behaviour.parallel.ParallelBehaviour

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new ParallelBehaviour

	def IBehaviour getSuccessNode() {
		val result = mock(IBehaviour) => [
			when(it.state).thenReturn(BehaviourState.SUCCESS)

			doAnswer[
				scheduler.notifyChildSuccess
				return null
			].when(it).execute
		]
		return result
	}

	def IBehaviour getFailedNode() {
		val result = mock(IBehaviour) => [
			when(it.state).thenReturn(BehaviourState.FAILED)

			doAnswer[
				scheduler.notifyChildFailed
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
		scheduler.addChild(successNode)
		scheduler.addChild(failedNode)

		scheduler.execute
		scheduler.execute

		assertThat(scheduler.state, equalTo(BehaviourState.FAILED))
	}

}