package ru.agentlab.maia.execution.scheduler.sequence.test

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.execution.tree.IExecutionAction
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequnceSchedulerTests {

	@Mock
	IExecutionAction action1

	@Mock
	IExecutionAction action2

	IExecutionScheduler scheduler

	@Mock
	IMaiaContext root

	@Mock
	IMaiaContext child1

	@Mock
	IMaiaContext child2

	@Test
	def void test() {
		for (ctx : #[root, child1, child2]) {
			when(ctx.get(IMaiaContext)).thenReturn(ctx)
			when(ctx.get(IMaiaContextInjector)).thenReturn(mock(IMaiaContextInjector))
			when(ctx.get(IMaiaServiceDeployer)).thenReturn(mock(IMaiaServiceDeployer))
		}
		when(child1.parent).thenReturn(root)
		when(child2.parent).thenReturn(root)
		when(root.childs).thenReturn(#[child1, child2])

		when(root.get(IExecutionNode)).thenReturn(scheduler)
		when(child1.get(IExecutionNode)).thenReturn(action1)
		when(child2.get(IExecutionNode)).thenReturn(action2)

		assertArrayEquals(#[action1, action2], scheduler.childs)
	}

}