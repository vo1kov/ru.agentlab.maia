package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class ContextRemoveByClassAbstractTests extends ContextAbstractTests {

	@Test
	def void shouldReturnNull() {
		val service = new DummyService
		context.set(DummyService, service)
		
		context.remove(DummyService)

		assertThat(context.get(DummyService), nullValue)
	}

	@Test
	def void shouldRemoveKeyFromKeySet() {
		val service = new DummyService
		context.set(DummyService, service)
		
		context.remove(DummyService)

		assertThat(context.keySet, not(containsInAnyOrder(#[DummyService.name])))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.remove(null as Class<?>)
	}

}