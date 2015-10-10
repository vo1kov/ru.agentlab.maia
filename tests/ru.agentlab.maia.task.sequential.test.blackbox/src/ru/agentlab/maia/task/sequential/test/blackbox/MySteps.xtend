package ru.agentlab.maia.task.sequential.test.blackbox

import java.util.Random
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITask.State
import ru.agentlab.maia.task.ITaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*
import javax.inject.Provider

class MySteps {

	var ITaskScheduler scheduler

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
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

	@Given("scheduler subtasks states are $states")
	def void givenSchedulerWithSubtasks(String statesString) {
		val String[] states = statesString.split(",")
		for (stateString : states) {
			val state = State.valueOf(stateString.trim)
			val task = mock(ITask) => [
				when(it.state).thenReturn(state)
				doAnswer[
					switch (state) {
						case WORKING: {
							scheduler.notifySubtaskWorking
						}
						case BLOCKED: {
							scheduler.notifySubtaskBlocked
						}
						case SUCCESS: {
							scheduler.notifySubtaskSuccess
						}
						case FAILED: {
							scheduler.notifySubtaskFailed
						}
						default: {
							throw new IllegalArgumentException
						}
					}
					return null
				].when(it).execute
			]
			scheduler.addSubtask(task)
		}
	}

	@Given("scheduler have $state state")
	def void givenSchedulerInState(String state) {
		scheduler.state = State.valueOf(state)
	}

	@When("add new subtask")
	def void whenSchedulerAddNewSubtask() {
		val added = mock(ITask)
		scheduler.addSubtask(added)
	}

	@When("add existing subtask")
	def void whenSchedulerAddExistingSubtask() {
		val added = scheduler.subtasks.get((new Random).nextInt(scheduler.subtasks.size))
		scheduler.addSubtask(added)
	}

	@When("execute scheduler $times times")
	def void whenSchedulerExecuteSchedulerTimes(int times) {
		for (i : 0 ..< times) {
			scheduler.execute
		}
	}

	@When("clear scheduler")
	def void whenSchedulerClear() {
		scheduler.clear
	}

	@When("remove existing subtask")
	def void whenSchedulerRemoveExistingSubtask() {
		val removed = scheduler.subtasks.get((new Random).nextInt(scheduler.subtasks.size))
		scheduler.removeSubtask(removed)
	}

	@When("remove unknown subtask")
	def void whenSchedulerRemoveNonExistingSubtask() {
		val removed = mock(ITask)
		scheduler.removeSubtask(removed)
	}

	@Then("scheduler contains $size subtasks")
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