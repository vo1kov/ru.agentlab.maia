package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITask
import ru.agentlab.maia.task.ITaskScheduler

import static org.mockito.Mockito.*

class AbstractTaskSchedulerAddSubtaskSteps {

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
	}

	@When("add new subtask")
	def void whenSchedulerAddNewSubtask() {
		val added = mock(ITask)
		provider.get.addSubtask(added)
	}

	@When("add existing subtask")
	def void whenSchedulerAddExistingSubtask() {
		val added = provider.get.subtasks.get((new Random).nextInt(provider.get.subtasks.size))
		provider.get.addSubtask(added)
	}

}