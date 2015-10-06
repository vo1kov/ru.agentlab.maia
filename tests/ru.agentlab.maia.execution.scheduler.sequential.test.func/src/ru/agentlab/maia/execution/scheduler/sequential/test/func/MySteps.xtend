package ru.agentlab.maia.execution.scheduler.sequential.test.func

import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import org.jbehave.core.annotations.When
import org.mockito.Mockito
import ru.agentlab.maia.execution.ITask

class MySteps {
	
	@Given("Scheduler with $size subtasks") 
	def void givenSchedulerWithSubtasks(int size) {
		System.out.println("WORKS" + size)
	}

	@When("Remove any existing subtask") 
	def void whenRemoveAnyExistingSubtask() {
		Mockito.mock(ITask)
	}

	@Then("step represents the outcome of the event") 
	def void whenRemoveAnyExistingSubtask1() {
	}

}
