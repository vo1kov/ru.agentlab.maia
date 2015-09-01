package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.ArrayList
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner
import ru.agentlab.maia.execution.scheduler.sequence.SequenceContextScheduler
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IExecutionScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerAddChildTests {

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void addChildsChangeQueueSize() {
		val size = 10
		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
		}
		assertThat(scheduler.childs, iterableWithSize(size))
	}

	@Test
	def void addChildsInSameOrder() {
		val size = 10
		val cache = new ArrayList<IExecutionNode>

		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
			cache.add(i, action)
		}
		assertThat(scheduler.childs, contains(cache.toArray))
	}

	@Test
	def void addChildsDuplicatesNotChangeQueue() {
		val size = 10
		val cache = new ArrayList<IExecutionNode>

		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
			cache.add(i, action)
		}
		assertThat(scheduler.childs, iterableWithSize(size))
		assertThat(scheduler.childs, contains(cache.toArray))

		for (i : 0 ..< size) {
			val action = cache.get(i)
			scheduler.addChild(action)
		}
		assertThat(scheduler.childs, iterableWithSize(size))
		assertThat(scheduler.childs, contains(cache.toArray))
	}

}
