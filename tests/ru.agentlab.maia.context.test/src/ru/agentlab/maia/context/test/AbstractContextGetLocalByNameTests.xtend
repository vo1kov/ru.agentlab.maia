package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.test.internal.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextGetLocalByNameTests extends AbstractContextTests {

	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.getLocal(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldNotRetrieveServiceWhenInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.getLocal(DummyService.name)

		assertThat(stored, nullValue)
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		val stored = context.getLocal(null as String)

		assertThat(stored, nullValue)
	}
	
}