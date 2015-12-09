package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

import static org.mockito.Mockito.*

class AbstractTaskSchedulerRemoveSubtaskSteps {

	val Provider<IBehaviourScheduler> provider

	new(Provider<IBehaviourScheduler> provider) {
		this.provider = provider
	}

	@When("remove existing subtask")
	def void whenSchedulerRemoveExistingSubtask() {
		val removed = provider.get.childs.get((new Random).nextInt(provider.get.childs.size))
		provider.get.removeChild(removed)
	}

	@When("remove unknown subtask")
	def void whenSchedulerRemoveNonExistingSubtask() {
		val removed = mock(IBehaviour)
		provider.get.removeChild(removed)
	}

}