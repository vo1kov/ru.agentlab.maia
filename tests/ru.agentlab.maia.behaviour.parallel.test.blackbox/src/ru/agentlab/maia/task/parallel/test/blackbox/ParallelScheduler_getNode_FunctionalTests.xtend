package ru.agentlab.maia.task.parallel.test.blackbox

import org.junit.Ignore
import org.junit.Test
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.behaviour.parallel.BehaviourSchedulerParallel

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class ParallelScheduler_getNode_FunctionalTests {

	val scheduler = new BehaviourSchedulerParallel

	def IBehaviour getSuccessNode() {
		val result = mock(IBehaviour) => [
			when(it.state).thenReturn(IBehaviour.State.SUCCESS)
		]
		return result
	}

	def IBehaviour getFailedNode() {
		val result = mock(IBehaviour) => [
			when(it.state).thenReturn(IBehaviour.State.FAILED)
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

		assertThat(scheduler.state, equalTo(IBehaviour.State.FAILED))
	}

}
