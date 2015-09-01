package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.ArrayList
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerNextChildTests {

	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void nextChildWithEmptyQueue() {
		val IExecutionScheduler spy = spy(scheduler)
		when(spy.getChilds).thenReturn(#[])
		val next = spy.nextChild
		assertThat(next, nullValue)
	}
	
	@Test
	def void nextChildChangeCurrenChild() {
		val childsCount = 10
		val scheduleCount = 2

		assertThat(scheduler.childs, emptyIterable)
		for (i : 0 ..< childsCount) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
		}
		
		for (i : 0 ..< scheduleCount) {
			val currentBefore = scheduler.currentChild
			val next = scheduler.nextChild
			assertThat(next, not(equalTo(currentBefore)))
			val currentAfter = scheduler.currentChild
			assertThat(currentAfter, not(equalTo(currentBefore)))
			assertThat(next, equalTo(currentAfter))
		}
	}
	

	@Test
	def void nextChildInOrder() {
		val childsCount = 10
		val scheduleCount = 100
		val cache = new ArrayList<IExecutionNode>

		assertThat(scheduler.childs, emptyIterable)
		for (i : 0 ..< childsCount) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
			cache.add(i, action)
		}

		for (i : 0 ..< scheduleCount) {
			val next = scheduler.nextChild
			val expected = cache.get(i % childsCount)
			assertThat(next, equalTo(expected))
		}
	}

	@Test
	def void nextChildBeginFromFirst() {
		val childsCount = 10
		var IExecutionNode first = mock(IExecutionNode)

		assertThat(scheduler.childs, emptyIterable)
		scheduler.addChild(first)
		for (i : 0 ..< childsCount - 1) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
		}
		assertThat(scheduler.nextChild, equalTo(first))
	}
}