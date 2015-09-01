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

	extension SequenceSchedulerTestExtension = new SequenceSchedulerTestExtension

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void removeAllClearsQueueSize() {
		when(scheduler.childs).thenReturn(getFakeChilds(10))

		scheduler.removeAll

		assertThat(scheduler.childs, emptyIterable)
	}

	@Test
	def void removeAllClearsCurrenNode() {
		val childs = getFakeChilds(10)
		when(scheduler.childs).thenReturn(childs)
		scheduler.currentChild = childs.get(rnd.nextInt(10))

		scheduler.removeAll

		assertThat(scheduler.currentChild, nullValue)
	}

	@Test
	def void removeAllStartsSchedulingFromBegin() {
		val childs = getFakeChilds(10)
		when(scheduler.childs).thenReturn(childs)
		scheduler.currentChild = childs.get(rnd.nextInt(10))

		scheduler.removeAll
		val newChilds = getFakeChilds(10)
		when(scheduler.childs).thenReturn(newChilds)

		assertThat(scheduler.nextChild, equalTo(newChilds.get(0)))
	}

}