package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.ArrayList
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
class SequenceSchedulerAddChildTests {

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void shouldIncreaseQueueSize() {
		assertThat(scheduler.subtasks, emptyIterable)
		val size = 10
		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addSubtask(action)
		}
		assertThat(scheduler.subtasks, iterableWithSize(size))
	}

	@Test
	def void shouldSilenceOnNull() {
		val lastSize = scheduler.subtasks.size
		scheduler.addSubtask(null)
		assertThat(scheduler.subtasks, iterableWithSize(lastSize))
	}

	@Test
	def void shouldAddWithSameOrder() {
		val size = 10
		val cache = new ArrayList<IExecutionNode>
		assertThat(scheduler.subtasks, emptyIterable)

		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addSubtask(action)
			cache.add(i, action)
		}
		assertThat(scheduler.subtasks, iterableWithSize(size))
		assertThat(scheduler.subtasks, contains(cache.toArray))
	}

	@Test
	def void shouldAddDuplicatesWithoutChangingQueue() {
		val size = 10
		val cache = new ArrayList<IExecutionNode>
		assertThat(scheduler.subtasks, emptyIterable)

		for (i : 0 ..< size) {
			val action = mock(IExecutionNode)
			scheduler.addSubtask(action)
			cache.add(i, action)
		}
		assertThat(scheduler.subtasks, iterableWithSize(size))
		assertThat(scheduler.subtasks, contains(cache.toArray))

		for (i : 0 ..< size) {
			val action = cache.get(i)
			scheduler.addSubtask(action)
		}
		assertThat(scheduler.subtasks, iterableWithSize(size))
		assertThat(scheduler.subtasks, contains(cache.toArray))
	}

}
