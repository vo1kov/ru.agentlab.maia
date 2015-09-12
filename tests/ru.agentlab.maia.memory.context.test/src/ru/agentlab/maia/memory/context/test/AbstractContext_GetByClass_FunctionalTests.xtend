package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_GetByClass_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}

	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceWhenInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.get(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.get(null as Class<?>)
	}

}