package ru.agentlab.maia.execution.scheduler.sequential.test.func

import java.util.Random
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.ITask.State
import ru.agentlab.maia.execution.ITaskScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class MySteps {

	var ITaskScheduler scheduler

	val ITaskSchedulerProvider provider

	new(ITaskSchedulerProvider provider) {
		this.provider = provider
	}

	@Given("a scheduler")
	def void givenScheduler() {
		scheduler = provider.get
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
	def void schedulerInState(String state) {
		scheduler.state = State.valueOf(state)
	}

	@When("remove null subtask")
	def void removingNullSubtask() {
		scheduler.removeSubtask(null)
	}

	@When("execute scheduler $times times")
	def void executeSchedulerByTimes(int times) {
		for (i : 0 ..< times) {
			scheduler.execute
		}
	}

	@When("clear scheduler")
	def void clearScheduler() {
		scheduler.clear
	}

	@When("remove existing subtask")
	def void removingExistingSubtask() {
		val removed = scheduler.subtasks.get((new Random).nextInt(scheduler.subtasks.size))
		scheduler.removeSubtask(removed)
	}

	@When("remove unknown subtask")
	def void removingNonExistingSubtask() {
		val removed = mock(ITask)
		scheduler.removeSubtask(removed)
	}

	@Then("scheduler contains $size subtasks")
	def void whenRemoveAnyExistingSubtask1(int size) {
		assertThat(scheduler.subtasks.size, equalTo(size))
	}

	@Then("scheduler is in $state state")
	def void whenRemoveAnyExistingSubtask12(String state) {
		assertThat(scheduler.state, equalTo(State.valueOf(state)))
	}

}