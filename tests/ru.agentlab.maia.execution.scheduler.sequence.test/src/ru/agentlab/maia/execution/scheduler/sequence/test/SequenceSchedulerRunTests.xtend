package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.Collections
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRunTests {

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void runDelegatesToEmptyChilds() {
		when(scheduler.childs).thenReturn(Collections.EMPTY_LIST)

		scheduler.run
	}
	
	@Test
	def void runDelegatesToSingleChilds() {
		val child = mock(IExecutionNode)
		when(scheduler.childs).thenReturn(#[child])

		scheduler.run

		verify(child).run
	}

	@Test
	def void runDelegatesToMultipleChilds() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))
		for (i : 0 ..< size) {
			
			scheduler.run
			
			verify(childs.get(i)).run
		}
	}
}