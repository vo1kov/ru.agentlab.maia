package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.test.internal.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class ContextGetByNameAbstractTests extends ContextAbstractTests {

	@Test
	def void shouldRetrieveServiceWhenInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceWhenInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.get(null as String)
	}

}