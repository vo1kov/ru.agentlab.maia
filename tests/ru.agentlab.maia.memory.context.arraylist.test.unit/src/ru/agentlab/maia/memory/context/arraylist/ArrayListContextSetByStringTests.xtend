package ru.agentlab.maia.memory.context.arraylist

import org.junit.Before
import org.junit.Test
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class ArrayListContextSetByStringTests {

	val ctx = new ListContext

	val keys = spy(ctx.keys)

	val values = spy(ctx.values)

	val service = mock(DummyService)

	@Before
	def void berore() {
		keys.clear
		values.clear
	}

	@Test
	def void shouldKeysAndValuesHaveSameSize() {
		ctx.set(DummyService.name, service)

		assertThat(keys.size, equalTo(values.size))
	}

	@Test
	def void shouldAddNewValueOnlyOnce() {
		ctx.set(DummyService.name, service)

		verify(keys, times(1)).add(DummyService.name)
		verify(values, times(1)).add(service)
	}

}