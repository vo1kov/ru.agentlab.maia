package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.Random
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRemoveAllTests {

	val rnd = new Random

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void removeAllClearsQueueSize() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))

		scheduler.removeAll

		assertThat(scheduler.childs, emptyIterable)
	}

	@Test
	def void removeAllClearsCurrenNode() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))
		scheduler.currentChild = childs.get(rnd.nextInt(childs.size))
		assertThat(scheduler.currentChild, notNullValue)
		assertThat(scheduler.currentChild, isIn(scheduler.childs))

		scheduler.removeAll

		assertThat(scheduler.currentChild, nullValue)
	}

	@Test
	def void removeAllStartsSchedulingFromBegin() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, not(emptyIterable))
		scheduler.currentChild = childs.get(rnd.nextInt(childs.size))
		assertThat(scheduler.currentChild, notNullValue)
		assertThat(scheduler.currentChild, isIn(scheduler.childs))

		scheduler.removeAll
		val newSize = 10
		val newChilds = getFakeChilds(newSize)
		when(scheduler.childs).thenReturn(newChilds)

		assertThat(scheduler.nextChild, equalTo(newChilds.get(0)))
	}

}