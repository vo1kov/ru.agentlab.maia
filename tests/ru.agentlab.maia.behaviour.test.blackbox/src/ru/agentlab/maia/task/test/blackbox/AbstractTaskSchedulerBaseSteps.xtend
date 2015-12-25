package ru.agentlab.maia.task.test.blackbox

import javax.inject.Provider
import org.jbehave.core.annotations.Given
import org.jbehave.core.annotations.Then
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

class AbstractTaskSchedulerBaseSteps {

	val TaskSchedulerStorage provider

	Provider<IBehaviourScheduler> factory

	new(TaskSchedulerStorage provider, Provider<IBehaviourScheduler> factory) {
		this.provider = provider
		this.factory = factory
	}

	@Given("a scheduler")
	def void givenScheduler() {
		provider.set(factory.get)
	}

	@Given("scheduler have $size subtasks")
	def void givenSchedulerWithSubtasks(int size) {
		for (i : 0 ..< size) {
			provider.get.addChild(mock(IBehaviour))
		}
	}

	@Given("scheduler have $state state")
	def void givenSchedulerInState(String state) {
		provider.get.state = Behaviour.State.valueOf(state)
	}

	@Then("scheduler have $size subtasks")
	def void thenSchedulerSubtasksSize(int size) {
		assertThat(provider.get.childs.size, equalTo(size))
	}

	@Then("scheduler have $state state")
	def void thenSchedulerState(String state) {
		assertThat(provider.get.state, equalTo(Behaviour.State.valueOf(state)))
	}

	@Then("scheduler don't change state")
	def void thenSchedulerDontChangeState() {
		verify(provider.get, times(0)).setState(anyObject)
	}

}