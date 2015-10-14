package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITaskScheduler

class TaskScheduler_clear_Steps extends TaskScheduler_Steps {

	new(Provider<ITaskScheduler> provider) {
		super(provider)
	}

	@When("clear scheduler")
	def void whenSchedulerClear() {
		scheduler.clear
	}

}