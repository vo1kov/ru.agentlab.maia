package ru.agentlab.maia.execution.scheduler.sequence.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionAction
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.mockito.Mockito.*
import java.util.Collections

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRunTests {

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Mock
	IExecutionAction child

	@Test
	def void runDelegatesToChild() {
		when(scheduler.childs).thenReturn(#[child])

		scheduler.run

		verify(child).run
	}
	
	
	@Test
	def void runWithEmptyChilds() {
		when(scheduler.childs).thenReturn(Collections.EMPTY_LIST)
		
		scheduler.run
	}
}