package ru.agentlab.maia.memory.context.arraylist

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.context.test.unit.VariableSizeCotextTests
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class ArrayContextSetByClassTests extends VariableSizeCotextTests<ArrayContext> {

	@Accessors
	val context = new ArrayContext

	val service = new DummyService

	extension ArrayContextTestsExtension = new ArrayContextTestsExtension

	new(String[] keys, Object[] values) {
		context.keys.addAll(keys)
		context.values.addAll(values)
	}

	@Test
	def void shouldKeysAndValuesHaveSameSize() {
		context.putService(DummyService, service)

		assertThat(context.keys.size, equalTo(context.values.size))
	}

	@Test
	def void shouldIncreaseSizeWhenNoValue() {
		context.prepareWithOutService(DummyService.name)
		val keysSizeBefore = context.keys.size
		val valuesSizeBefore = context.values.size

		context.putService(DummyService, service)

		assertThat(context.keys.size - keysSizeBefore, equalTo(1))
		assertThat(context.values.size - valuesSizeBefore, equalTo(1))
	}

	@Test
	def void shouldNotIncreaseSizeWhenExistValue() {
		context.prepareWithService(DummyService.name, service)
		val keysSizeBefore = context.keys.size
		val valuesSizeBefore = context.values.size

		context.putService(DummyService, service)

		assertThat(context.keys.size, equalTo(keysSizeBefore))
		assertThat(context.values.size, equalTo(valuesSizeBefore))
	}

	@Test
	def void shouldChangeWhenExistValue() {
		context.prepareWithService(DummyService.name, service)
		val keyIndex = context.keys.indexOf(DummyService.name)
		val newService = new DummyService

		context.putService(DummyService, newService)

		assertThat(context.keys.get(keyIndex), equalTo(DummyService.name))
		assertThat(context.values.get(keyIndex) as DummyService, not(service))
		assertThat(context.values.get(keyIndex) as DummyService, equalTo(newService))
	}

	@Test
	def void shouldAddWhenNoValue() {
		context.prepareWithOutService(DummyService.name)

		context.putService(DummyService, service)

		assertThat(context.keys.last, equalTo(DummyService.name))
		assertThat(context.values.last, is(instanceOf(DummyService)))
		assertThat(context.values.last as DummyService, equalTo(service))
	}

	@Test
	def void shouldKeyEqualsToClassName() {
		context.prepareWithOutService(DummyService.name)
		context.putService(DummyService, service)
		val keyIndex = context.keys.indexOf(DummyService.name)

		assertThat(context.keys.get(keyIndex), equalTo(DummyService.name))
	}

}