package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler
import ru.agentlab.maia.task.TaskState

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class AbstractTaskSchedulerExecuteSteps {

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
	}

	@Given("scheduler subtasks states are $states")
	def void givenSchedulerWithSubtasks(String statesString) {
		val String[] states = statesString.split(",")
		for (stateString : states) {
			val state = TaskState.valueOf(stateString.trim)
			val task = mock(ITask) => [
				when(it.state).thenReturn(state)
				doAnswer[
					switch (state) {
						case WORKING: {
							provider.get.notifySubtaskWorking
						}
						case BLOCKED: {
							provider.get.notifySubtaskBlocked
						}
						case SUCCESS: {
							provider.get.notifySubtaskSuccess
						}
						case FAILED: {
							provider.get.notifySubtaskFailed
						}
						default: {
							throw new IllegalArgumentException
						}
					}
					return null
				].when(it).execute
			]
			provider.get.addSubtask(task)
		}
	}

	@When("execute scheduler $times times")
	def void whenSchedulerExecuteSchedulerTimes(int times) {
		for (i : 0 ..< times) {
			provider.get.execute
		}
	}

	@Then("scheduler have $state state")
	def void thenSchedulerState(String state) {
		assertThat(provider.get.state, equalTo(TaskState.valueOf(state)))
	}

}