package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_removeByString_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context, ServiceRegistration selfServices, ServiceRegistration parentServices) {
		super(context, selfServices, parentServices)
	}
	
	@Test
	def void shouldReturnNull() {
		val service = new DummyService
		context.putService(DummyService.name, service)

		context.remove(DummyService.name)

		assertThat(context.getService(DummyService), nullValue)
	}

	@Test
	def void shouldRemoveKeyFromKeySet() {
		val service = new DummyService
		context.putService(DummyService.name, service)

		context.remove(DummyService.name)

		assertThat(context.keySet, not(hasItem(KEY_STRING_VALID)))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.remove(null as String)
	}

}