package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.ArrayList
import java.util.Random
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
class SequenceSchedulerRemoveChildTests {

	val rnd = new Random

	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void shouldSilenceOnUnknownChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		val removed = scheduler.removeSubtask(mock(IExecutionNode))

		assertThat(removed, nullValue)
		assertThat(scheduler.subtasks, iterableWithSize(size))
		assertThat(scheduler.subtasks, contains(childs.toArray))
	}

	@Test
	def void shouldReturnNullOnUnknownChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		val removed = scheduler.removeSubtask(mock(IExecutionNode))

		assertThat(removed, nullValue)
	}

	@Test
	def void shouldSilenceOnNullChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		scheduler.removeSubtask(null)

		assertThat(scheduler.subtasks, iterableWithSize(size))
		assertThat(scheduler.subtasks, contains(childs.toArray))
	}

	@Test
	def void shouldReturnNullOnNullChild() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		val removed = scheduler.removeSubtask(null)

		assertThat(removed, nullValue)
	}

	@Test
	def void shouldReturnRemoved() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		val toRemove = childs.get(rnd.nextInt(childs.size))
		val removed = scheduler.removeSubtask(toRemove)

		assertThat(removed, equalTo(toRemove))
	}

	@Test
	def void shouldDecreaseQueueSize() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(size))

		scheduler.removeSubtask(childs.get(rnd.nextInt(childs.size)))

		assertThat(scheduler.subtasks, iterableWithSize(size - 1))
	}

	@Test
	def void shouldClearCurrenNodeWhenLast() {
		val child = mock(IExecutionNode)
		val childs = new ArrayList<IExecutionNode> => [
			add(child)
		]
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, iterableWithSize(1))
//		scheduler.current = child
//		assertThat(scheduler.current, notNullValue)
//
//		scheduler.removeChild(child)
//
//		assertThat(scheduler.current, nullValue)
	}

	@Test
	def void shouldRemoveFromQueue() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		val toRemove = childs.get(rnd.nextInt(childs.size))
		assertThat(toRemove, isIn(scheduler.subtasks))

		scheduler.removeSubtask(toRemove)

		assertThat(toRemove, not(isIn(scheduler.subtasks)))
	}

}