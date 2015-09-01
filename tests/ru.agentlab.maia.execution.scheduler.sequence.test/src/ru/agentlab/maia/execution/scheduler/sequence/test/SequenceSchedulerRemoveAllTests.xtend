package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.Random
import org.junit.Test
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class SequenceSchedulerRemoveAllTests {

	val rnd = new Random

	IExecutionScheduler scheduler = new SequenceContextScheduler

	def private void fillScheduler(IExecutionScheduler scheduler, int count) {
		for (i : 0 ..< count) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
		}
	}

	@Test
	def void removeAllClearsQueueSize() {
		scheduler.fillScheduler(10)
		assertThat(scheduler.childs, iterableWithSize(greaterThan(0)))
		scheduler.removeAll
		assertThat(scheduler.childs, emptyIterable)
	}

	@Test
	def void removeAllClearsCurrenNode() {
		scheduler.fillScheduler(10)
		for (i : 0 ..< rnd.nextInt(10)) {
			scheduler.nextChild
		}
		assertThat(scheduler.currentChild, notNullValue)
		scheduler.removeAll
		assertThat(scheduler.currentChild, nullValue)
	}
	
	@Test
	def void removeAllStartsSchedulingFromBegin() {
		scheduler.fillScheduler(10)
		for (i : 0 ..< rnd.nextInt(10)) {
			scheduler.nextChild
		}
		assertThat(scheduler.currentChild, notNullValue)
		scheduler.removeAll
		assertThat(scheduler.currentChild, nullValue)
		assertThat(scheduler.childs, emptyIterable)
		
		var IExecutionNode first = mock(IExecutionNode)
		scheduler.addChild(first)
		scheduler.fillScheduler(10)
		assertThat(scheduler.nextChild, equalTo(first))
	}

}