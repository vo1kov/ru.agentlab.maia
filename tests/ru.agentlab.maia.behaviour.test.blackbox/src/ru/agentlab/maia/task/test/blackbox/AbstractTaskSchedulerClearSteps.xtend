package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.behaviour.IBehaviourScheduler

class AbstractTaskSchedulerClearSteps {

	val Provider<IBehaviourScheduler> provider

	new(Provider<IBehaviourScheduler> provider) {
		this.provider = provider
	}

	@When("clear scheduler")
	def void whenSchedulerClear() {
		provider.get.clear
	}

}