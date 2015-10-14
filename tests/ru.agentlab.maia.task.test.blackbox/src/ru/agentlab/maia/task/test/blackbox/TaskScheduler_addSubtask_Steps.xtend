package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler

import static org.mockito.Mockito.*

class TaskScheduler_addSubtask_Steps extends TaskScheduler_Steps {

	new(Provider<ITaskScheduler> provider) {
		super(provider)
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

}