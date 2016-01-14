package ru.agentlab.maia.task.test.blackbox

import java.util.Random
import javax.inject.Provider
import org.jbehave.core.annotations.When
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.IBehaviourScheduler

import static org.mockito.Mockito.*

class AbstractTaskSchedulerAddSubtaskSteps {

	val Provider<IBehaviourScheduler> provider

	new(Provider<IBehaviourScheduler> provider) {
		this.provider = provider
	}

	@When("add new subtask")
	def void whenSchedulerAddNewSubtask() {
		val added = mock(IBehaviour)
		provider.get.addChild(added)
	}

	@When("add existing subtask")
	def void whenSchedulerAddExistingSubtask() {
		val added = provider.get.childs.get((new Random).nextInt(provider.get.childs.size))
		provider.get.addChild(added)
	}

}