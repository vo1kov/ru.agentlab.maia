package ru.agentlab.maia.memory.context.arraylist

import org.junit.Test
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*
import org.junit.Before

class ArrayListContextSetByClassTests {

	val ctx = new ListContext

	val keys = spy(ctx.keys)

	val values = spy(ctx.values)

	val service = mock(DummyService)
	
	@Before
	def void berore(){
		keys.clear
		values.clear
	}

	@Test
	def void shouldKeysAndValuesHaveSameSize() {
		ctx.set(DummyService, service)

		assertThat(keys.size, equalTo(values.size))
	}

	@Test
	def void shouldIncreaseSize() {
		val keysSizeBefore = keys.size
		val valuesSizeBefore = values.size
		
		ctx.set(DummyService, service)

		assertThat(keys.size - keysSizeBefore, equalTo(1))
		assertThat(values.size - valuesSizeBefore, equalTo(1))
	}

	@Test
	def void shouldKeyEqualsToClassName() {
		ctx.set(DummyService, service)

		assertThat(keys.toArray, arrayWithSize(1))
		assertThat(keys.get(0), equalTo(DummyService.name))
	}

	@Test
	def void shouldAddNewValueOnlyOnce() {
		ctx.set(DummyService, service)

		verify(keys, times(1)).add(DummyService.name)
		verify(values, times(1)).add(service)
	}

}