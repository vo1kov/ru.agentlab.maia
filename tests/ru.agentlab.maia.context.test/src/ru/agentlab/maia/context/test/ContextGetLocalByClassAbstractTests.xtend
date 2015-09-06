package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.test.internal.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import ru.agentlab.maia.context.test.internal.DummyChildService
import ru.agentlab.maia.context.test.internal.DummyParentService

abstract class ContextGetLocalByClassAbstractTests extends ContextAbstractTests {

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
	
	@Test
	def void shouldRetrieveServiceFromClassHierarchy(){
		val service = new DummyChildService
		context.set(DummyChildService, service)

		val stored = context.getLocal(DummyParentService)

		assertThat(stored, equalTo(service))
	}

}