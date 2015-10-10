package ru.agentlab.maia.task.fsm.test.blackbox

import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.InjectMocks
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.fsm.FsmTaskScheduler
import ru.agentlab.maia.task.fsm.IFsmTaskScheduler

import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class FsmSchedulerStateTests {

//	@Mock
//	IMaiaContext context
//
//	@Mock
//	IMaiaContextInjector injector
	@Spy @InjectMocks
	IFsmTaskScheduler scheduler = new FsmTaskScheduler

	@Test
	def void shouldBeUnknownWhenConstructed() {
//		assertThat(scheduler.state, equalTo(State.UNKNOWN))
	}

	@Test
	def void shouldBeInstalledWhenDeployToContext() {
//		when(context.getServiceLocal(IMaiaContextInjector)).thenReturn(injector)
//		when(injector.invoke(scheduler, PostConstruct, null)).thenAnswer [
//			(scheduler as AbstractExecutionNode).init
//			return null
//		]
//		when(injector.deploy(scheduler)).thenAnswer [
////			(scheduler as AbstractExecutionNode).init
//			return null
//		]
//		injector.deploy(scheduler)
//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
	}

	@Test @Ignore
	def void shouldBeActiveWhenHaveTransitionChain() {
		val child = mock(ITask)
//		(scheduler as AbstractExecutionNode).init
//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
		scheduler.addSubtask(child)
		scheduler.addDefaultTransition(null, child)
		scheduler.addDefaultTransition(child, null)

//		assertThat(scheduler.state, equalTo(ITask.STATE_WORKING))
	}

	@Test @Ignore
	def void shouldNotChangeStateWhenAddTransition() {
		val child = mock(ITask)
//		(scheduler as AbstractExecutionNode).init
//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
		scheduler.addSubtask(child)
		scheduler.addDefaultTransition(null, child)

//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
	}

	@Test @Ignore
	def void shouldNotIncreaseStateWhenAddChild() {
		val child = mock(ITask)
//		(scheduler as AbstractExecutionNode).init
//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
		scheduler.addSubtask(child)

//		assertThat(scheduler.state, equalTo(ITask.STATE_READY))
	}
}