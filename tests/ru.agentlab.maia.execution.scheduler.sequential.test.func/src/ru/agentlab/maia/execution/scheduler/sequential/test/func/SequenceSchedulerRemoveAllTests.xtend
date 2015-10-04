package ru.agentlab.maia.execution.scheduler.sequential.test.func

import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Spy
import org.mockito.runners.MockitoJUnitRunner

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import ru.agentlab.maia.execution.ITaskScheduler
import ru.agentlab.maia.execution.scheduler.sequential.SequentialTaskScheduler

@RunWith(MockitoJUnitRunner)
class SequenceSchedulerRemoveAllTests {

//	val rnd = new Random
	extension SequenceSchedulerTestsExtension = new SequenceSchedulerTestsExtension

	@Spy
	ITaskScheduler scheduler = new SequentialTaskScheduler

	@Test
	def void shouldClearQueueSize() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))

		scheduler.removeAllChilds

		assertThat(scheduler.subtasks, emptyIterable)
	}

	@Test
	def void shouldClearCurrenNode() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))
//		scheduler.current = childs.get(rnd.nextInt(childs.size))
//		assertThat(scheduler.current, notNullValue)
//		assertThat(scheduler.current, isIn(scheduler.childs))
//
//		scheduler.removeAll
//
//		assertThat(scheduler.current, nullValue)
	}

	@Test
	def void shouldStartSchedulingFromBegin() {
		val size = 10
		val childs = getFakeChilds(size)
		when(scheduler.subtasks).thenReturn(childs)
		assertThat(scheduler.subtasks, not(emptyIterable))
//		scheduler.current = childs.get(rnd.nextInt(childs.size))
//		assertThat(scheduler.current, notNullValue)
//		assertThat(scheduler.current, isIn(scheduler.childs))
//
//		scheduler.removeAll
//		val newSize = 10
//		val newChilds = getFakeChilds(newSize)
//		when(scheduler.childs).thenReturn(newChilds)
//
//		assertThat(scheduler.schedule, equalTo(newChilds.get(0)))
	}

}