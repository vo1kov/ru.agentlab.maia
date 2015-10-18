package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler

import static org.mockito.Mockito.*

class AbstractTaskSchedulerRemoveSubtaskSteps {

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
	}

	@When("remove existing subtask")
	def void whenSchedulerRemoveExistingSubtask() {
		val removed = provider.get.subtasks.get((new Random).nextInt(provider.get.subtasks.size))
		provider.get.removeSubtask(removed)
	}

	@When("remove unknown subtask")
	def void whenSchedulerRemoveNonExistingSubtask() {
		val removed = mock(ITask)
		provider.get.removeSubtask(removed)
	}

}