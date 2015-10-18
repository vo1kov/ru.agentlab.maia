package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.task.ITaskScheduler

class AbstractTaskSchedulerClearSteps {

	val Provider<ITaskScheduler> provider

	new(Provider<ITaskScheduler> provider) {
		this.provider = provider
	}

	@When("clear scheduler")
	def void whenSchedulerClear() {
		provider.get.clear
	}

}