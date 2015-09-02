package ru.agentlab.maia.execution.scheduler.sequence.test

import javax.annotation.PostConstruct
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Mock
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.IMaiaServiceDeployer
import ru.agentlab.maia.context.MaiaServiceDeployer
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerDeploymentTests {

	@Mock
	IMaiaContext context

	@Mock
	IMaiaContextInjector injector

	IMaiaServiceDeployer deployer

	@Spy @InjectMocks
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void shouldChangeStateToInstalled() {
		deployer = new MaiaServiceDeployer(context)
		when(context.getLocal(IMaiaContextInjector)).thenReturn(injector)
		when(injector.invoke(scheduler, PostConstruct, null)).thenAnswer [
			(scheduler as SequenceContextScheduler).init
			return null
		]

		deployer.deploy(scheduler)

		assertThat(scheduler.state, equalTo(ExecutionNodeState.INSTALLED))
	}
}