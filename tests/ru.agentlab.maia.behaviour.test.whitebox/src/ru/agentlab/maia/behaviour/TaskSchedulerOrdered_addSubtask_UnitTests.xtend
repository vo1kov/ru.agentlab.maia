package ru.agentlab.maia.behaviour

import org.mockito.Spy
import ru.agentlab.maia.IBehaviour

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class TaskSchedulerOrdered_addSubtask_UnitTests {

	var protected IBehaviour task = createTask()

	@Spy
	var protected BehaviourScheduler scheduler

	def static IBehaviour createTask() {
		return mock(IBehaviour)
	}

	def void before() {
		doCallRealMethod.when(scheduler).addChild(task)
	}

	@org.junit.Test
	def void index_notChanged_whenIndexOn0() {
		scheduler.childs.clear
		scheduler.index = 0

		scheduler.addChild(createTask)

		assertThat(scheduler.index, equalTo(1))
	}

	@org.junit.Test
	def void index_notChanged_whenIndexOnLast() {
		val size = 10
		val lastIndex = size - 1
		scheduler.childs => [
			clear
			for (i : 0 ..< size) {
				add(createTask)
			}
		]
		scheduler.index = lastIndex

		scheduler.addChild(createTask)

		assertThat(scheduler.index, equalTo(lastIndex))
	}

	@org.junit.Test(expected=NullPointerException)
	def void addSubtask_throw_whenNullArgs() {
		scheduler.addChild(task)
	}

}