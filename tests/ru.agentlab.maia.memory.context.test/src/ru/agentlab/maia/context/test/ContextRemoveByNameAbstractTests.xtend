package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class ContextRemoveByNameAbstractTests extends ContextAbstractTests {

	@Test
	def void shouldReturnNull() {
		val service = new DummyService
		context.set(DummyService.name, service)

		context.remove(DummyService.name)

		assertThat(context.get(DummyService), nullValue)
	}

	@Test
	def void shouldRemoveKeyFromKeySet() {
		val service = new DummyService
		context.set(DummyService.name, service)

		context.remove(DummyService.name)

		assertThat(context.keySet, not(containsInAnyOrder(#[DummyService.name])))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.remove(null as String)
	}

}