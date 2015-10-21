package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskState

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

class AbstractTaskSchedulerBaseSteps {

	val TaskSchedulerStorage provider

	Provider<ITaskScheduler> factory

	new(TaskSchedulerStorage provider, Provider<ITaskScheduler> factory) {
		this.provider = provider
		this.factory = factory
	}

	@Given("a scheduler")
	def void givenScheduler() {
		provider.set(factory.get)
	}

	@Given("scheduler have $size subtasks")
	def void givenSchedulerWithSubtasks(int size) {
		for (i : 0 ..< size) {
			provider.get.addSubtask(mock(ITask))
		}
	}

	@Given("scheduler have $state state")
	def void givenSchedulerInState(String state) {
		provider.get.state = TaskState.valueOf(state)
	}

	@Then("scheduler have $size subtasks")
	def void thenSchedulerSubtasksSize(int size) {
		assertThat(provider.get.subtasks.size, equalTo(size))
	}

	@Then("scheduler have $state state")
	def void thenSchedulerState(String state) {
		assertThat(provider.get.state, equalTo(TaskState.valueOf(state)))
	}

	@Then("scheduler don't change state")
	def void thenSchedulerDontChangeState() {
		verify(provider.get, times(0)).setState(anyObject)
	}

}