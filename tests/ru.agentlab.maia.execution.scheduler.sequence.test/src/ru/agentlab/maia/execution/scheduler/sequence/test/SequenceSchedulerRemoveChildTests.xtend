package ru.agentlab.maia.execution.scheduler.sequence.test

import java.util.ArrayList
import java.util.Random
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
class SequenceSchedulerRemoveChildTests {

	val rnd = new Random

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	IExecutionScheduler scheduler = new SequenceContextScheduler

	@Test
	def void shouldSilenceOnUnknownChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))

		val removed = scheduler.removeChild(mock(IExecutionNode))

		assertThat(removed, nullValue)
		assertThat(scheduler.childs, iterableWithSize(size))
		assertThat(scheduler.childs, contains(childs.toArray))
	}
	
	@Test
	def void shouldReturnNullOnUnknownChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))

		val removed = scheduler.removeChild(mock(IExecutionNode))

		assertThat(removed, nullValue)
	}
	
	@Test
	def void shouldSilenceOnNullChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))

		scheduler.removeChild(null)

		assertThat(scheduler.childs, iterableWithSize(size))
		assertThat(scheduler.childs, contains(childs.toArray))
	}
	
	@Test
	def void shouldReturnNullOnNullChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))

		val removed = scheduler.removeChild(null)

		assertThat(removed, nullValue)
	}
	
	@Test
	def void shouldReturnRemoved() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))
		
		val toRemove = childs.get(rnd.nextInt(childs.size))
		val removed = scheduler.removeChild(toRemove)

		assertThat(removed, equalTo(toRemove))
	}
	
	@Test
	def void shouldDecreaseQueueSize() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(size))

		scheduler.removeChild(childs.get(rnd.nextInt(childs.size)))

		assertThat(scheduler.childs, iterableWithSize(size - 1))
	}

	@Test
	def void shouldClearCurrenNodeWhenLast() {
		val child = mock(IExecutionNode)
		val childs = new ArrayList<IExecutionNode> => [
			add(child)
		]
		when(scheduler.childs).thenReturn(childs)
		assertThat(scheduler.childs, iterableWithSize(1))
		scheduler.current = child
		assertThat(scheduler.current, notNullValue)

		scheduler.removeChild(child)

		assertThat(scheduler.current, nullValue)
	}

	@Test
	def void shouldRemoveFromQueue() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.childs).thenReturn(childs)
		val toRemove = childs.get(rnd.nextInt(childs.size))
		assertThat(toRemove, isIn(scheduler.childs))

		scheduler.removeChild(toRemove)

		assertThat(toRemove, not(isIn(scheduler.childs)))
	}

}