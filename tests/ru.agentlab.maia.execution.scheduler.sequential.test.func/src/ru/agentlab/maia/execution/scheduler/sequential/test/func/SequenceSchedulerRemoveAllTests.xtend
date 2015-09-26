package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.Random
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.IExecutionScheduler
import ru.agentlab.maia.execution.scheduler.sequental.OneShotSequentialScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRemoveAllTests {

	val rnd = new Random

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	IExecutionScheduler scheduler = new OneShotSequentialScheduler

	@Test
	def void shouldClearQueueSize() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))

		scheduler.removeAll

		assertThat(scheduler.childs, emptyIterable)
	}

	@Test
	def void shouldClearCurrenNode() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))
		scheduler.current = childs.get(rnd.nextInt(childs.size))
		assertThat(scheduler.current, notNullValue)
		assertThat(scheduler.current, isIn(scheduler.childs))

		scheduler.removeAll

		assertThat(scheduler.current, nullValue)
	}

	@Test
	def void shouldStartSchedulingFromBegin() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))
		scheduler.current = childs.get(rnd.nextInt(childs.size))
		assertThat(scheduler.current, notNullValue)
		assertThat(scheduler.current, isIn(scheduler.childs))

		scheduler.removeAll
		val newSize = 10
		val newChilds = getFakeChilds(newSize)
		when(scheduler.childs).thenReturn(newChilds)

		assertThat(scheduler.schedule, equalTo(newChilds.get(0)))
	}

}