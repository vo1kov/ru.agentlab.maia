package ru.agentlab.maia.execution.scheduler.sequential.test.func

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequentialTaskScheduler_execute_FunctionalTests {

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

//	@Before
//	def void before() {
//		scheduler.activate
//	}
	@Test
	def void shouldInvokeNextChild() {
//		scheduler.execute
//		verify(scheduler).schedule
	}

	@Test
	def void shouldDelegateToEmptyChilds() {
//		when(scheduler.subtasks).thenReturn(Collections.EMPTY_LIST)
//
//		scheduler.execute
	}

	@Test
	def void shouldDelegateToSingleChilds() {
		val child = mock(ITask)
		when(scheduler.subtasks).thenReturn(#[child])
		assertThat(scheduler.subtasks, iterableWithSize(1))

//		scheduler.execute
//
//		verify(child).execute
	}

	@Test
	def void shouldDelegateToMultipleChilds() {
//		val size = 10
//		val childs = getFakeChilds(size)
//		when(scheduler.subtasks).thenReturn(childs)
//		assertThat(scheduler.subtasks, iterableWithSize(size))
//		for (i : 0 ..< size) {
//
//			scheduler.execute
//
//			verify(childs.get(i)).execute
//		}
	}
}