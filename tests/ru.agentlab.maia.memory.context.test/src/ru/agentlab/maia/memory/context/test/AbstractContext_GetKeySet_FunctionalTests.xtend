package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_GetKeySet_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}

	@Test
	def void shouldContainKey() {
		context.set(DummyService, new DummyService)

		val keySet = context.keySet

		assertThat(keySet, containsInAnyOrder(#[DummyService.name]))
	}

	@Test
	def void shouldNotChangeKeySetWhenAddDuplicate() {
		context.set(DummyService, new DummyService)
		val beforeSize = context.keySet.size

		context.set(DummyService, new DummyService)
		val afterSize = context.keySet.size

		assertThat(afterSize, equalTo(beforeSize))
	}

}