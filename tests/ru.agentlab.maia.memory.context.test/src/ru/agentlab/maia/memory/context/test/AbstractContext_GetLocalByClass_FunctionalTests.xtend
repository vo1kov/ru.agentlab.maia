package ru.agentlab.maia.memory.context.test

import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService
import ru.agentlab.maia.memory.doubles.hierarchy.DummyChildService
import ru.agentlab.maia.memory.doubles.hierarchy.DummyParentService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_GetLocalByClass_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}
	
	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldNotRetrieveServiceWhenInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, nullValue)
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.getLocal(null as Class<?>)
	}

	@Test @Ignore
	def void shouldRetrieveServiceFromClassHierarchy() {
		val service = new DummyChildService
		context.set(DummyChildService, service)

		val stored = context.getLocal(DummyParentService)

		assertThat(stored, equalTo(service))
	}

}