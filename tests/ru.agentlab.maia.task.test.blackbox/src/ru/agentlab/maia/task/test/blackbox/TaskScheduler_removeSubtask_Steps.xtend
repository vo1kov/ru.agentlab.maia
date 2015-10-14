package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler

import static org.mockito.Mockito.*

class TaskScheduler_removeSubtask_Steps extends TaskScheduler_Steps {

	new(Provider<ITaskScheduler> provider) {
		super(provider)
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

}