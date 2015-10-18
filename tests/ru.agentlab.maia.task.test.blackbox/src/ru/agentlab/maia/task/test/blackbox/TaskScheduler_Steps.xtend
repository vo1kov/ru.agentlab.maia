package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.Aliases
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.ITaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

abstract class TaskScheduler_Steps {

	var ITaskScheduler scheduler

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
	}

	def ITaskScheduler getScheduler() {
		return scheduler
	}

	@Given("a scheduler")
	def void givenScheduler() {
		scheduler = spy(provider.get)
	}

	@Given("scheduler have $size subtasks")
	def void givenSchedulerWithSubtasks(int size) {
		for (i : 0 ..< size) {
			scheduler.addSubtask(mock(ITask))
		}
	}

	@Given("scheduler have $state state")
	def void givenSchedulerInState(String state) {
		scheduler.state = State.valueOf(state)
	}

	@Then("scheduler have $size subtasks")
	def void thenSchedulerSubtasksSize(int size) {
		assertThat(scheduler.subtasks.size, equalTo(size))
	}

	@Then("scheduler have $state state")
	def void thenSchedulerState(String state) {
		assertThat(scheduler.state, equalTo(State.valueOf(state)))
	}

	@Then("scheduler don't change state")
	def void thenSchedulerDontChangeState() {
		verify(scheduler, times(0)).setState(anyObject)
	}

}