package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.Collections
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.IExecutionNode

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRunTests {

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

//	@Before
//	def void before() {
//		scheduler.activate
//	}
	@Test
	def void shouldInvokeNextChild() {
		scheduler.run
//		verify(scheduler).schedule
	}

	@Test
	def void shouldDelegateToEmptyChilds() {
		when(scheduler.subtasks).thenReturn(Collections.EMPTY_LIST)

		scheduler.run
	}

	@Test
	def void shouldDelegateToSingleChilds() {
		val child = mock(IExecutionNode)
		when(scheduler.subtasks).thenReturn(#[child])
		assertThat(scheduler.subtasks, iterableWithSize(1))

		scheduler.run

		verify(child).run
	}

	@Test @Ignore
	def void shouldDelegateToMultipleChilds() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))
		for (i : 0 ..< size) {

			scheduler.run

			verify(childs.get(i)).run
		}
	}
}