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
class SequenceSchedulerAddChildTests {

	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void addChildsChangeQueueSize() {
		assertThat(scheduler.childs, emptyIterable)
		val uniqueCount = 10
		for (i : 0 ..< uniqueCount) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
		}
		assertThat(scheduler.childs, iterableWithSize(uniqueCount))
	}

	def void addChildsInSameOrder() {
		val cache = new ArrayList<IExecutionNode>

		val uniqueCount = 10
		for (i : 0 ..< uniqueCount) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
			cache.add(i, action)
		}
		assertThat(scheduler.childs, contains(cache.toArray))
	}

	@Test
	def void addDuplicatesNotChangeQueue() {
		val cache = new ArrayList<IExecutionNode>

		assertThat(scheduler.childs, emptyIterable)
		val uniqueCount = 10
		for (i : 0 ..< uniqueCount) {
			val action = mock(IExecutionNode)
			scheduler.addChild(action)
			cache.add(i, action)
		}
		assertThat(scheduler.childs, iterableWithSize(uniqueCount))
		assertThat(scheduler.childs, contains(cache.toArray))

		val duplicateCount = 10
		for (i : 0 ..< duplicateCount) {
			val action = cache.get(i % uniqueCount)
			scheduler.addChild(action)
		}
		assertThat(scheduler.childs, iterableWithSize(uniqueCount))
		assertThat(scheduler.childs, contains(cache.toArray))
	}

}
