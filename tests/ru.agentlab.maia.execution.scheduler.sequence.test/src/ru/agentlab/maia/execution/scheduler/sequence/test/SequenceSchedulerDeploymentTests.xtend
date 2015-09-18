package ru.agentlab.maia.execution.scheduler.sequence.test

import javax.annotation.PostConstruct
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.node.AbstractNode
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerDeploymentTests {

	@Mock
	IMaiaContext context

	@Mock
	IMaiaContextInjector injector

	@Spy @InjectMocks
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void shouldChangeStateToInstalled() {
		when(context.getServiceLocal(IMaiaContextInjector)).thenReturn(injector)
		when(injector.invoke(scheduler, PostConstruct, null)).thenAnswer [
			(scheduler as AbstractNode).init
			return null
		]
		when(injector.deploy(scheduler)).thenAnswer [
			(scheduler as AbstractNode).init
			return null
		]

		injector.deploy(scheduler)

		assertThat(scheduler.state, equalTo(IExecutionNode.INSTALLED))
	}
}