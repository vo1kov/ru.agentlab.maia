package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.Collections
import org.junit.Before
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.IExecutionNode
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRunTests {

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Before
	def void before() {
		scheduler.activate
	}

	@Test
	def void shouldInvokeNextChild() {
		scheduler.run
		verify(scheduler).schedule
	}

	@Test
	def void shouldDelegateToEmptyChilds() {
		when(scheduler.childs).thenReturn(Collections.EMPTY_LIST)

		scheduler.run
	}

	@Test
	def void shouldDelegateToSingleChilds() {
		val child = mock(IExecutionNode)
		when(scheduler.childs).thenReturn(#[child])
		assertThat(scheduler.childs, iterableWithSize(1))

		scheduler.run

		verify(child).run
	}

	@Test @Ignore
	def void shouldDelegateToMultipleChilds() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))
		for (i : 0 ..< size) {

			scheduler.run

			verify(childs.get(i)).run
		}
	}
}