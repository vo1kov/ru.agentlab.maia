package ru.agentlab.maia.memory.context.arraylist

import java.util.ArrayList
import java.util.Collection
import java.util.UUID
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class ArrayListContextSetByClassTests {

	val static contextSizes = #[0, 1, 2, 5, 10, 100]

	val ctx = new ListContext

	val service = new DummyService

	new(String[] keys, Object[] values) {
		ctx.keys.addAll(keys)
		ctx.values.addAll(values)
	}

	@Parameterized.Parameters
	def public static Collection<?> keysAndValues() {
		val result = new ArrayList
		contextSizes.forEach [ size |
			val String[] keys = newArrayOfSize(size)
			val Object[] values = newArrayOfSize(size)
			for (i : 0 ..< size) {
				keys.set(i, UUID.randomUUID.toString)
				values.set(i, new DummyService)
			}
			val Object[] args = newArrayOfSize(2)
			args.set(0, keys)
			args.set(1, values)
			result += args
		]
		return result
	}

	@Test
	def void shouldKeysAndValuesHaveSameSize() {
		ctx.set(DummyService, service)

		assertThat(ctx.keys.size, equalTo(ctx.values.size))
	}

	@Test
	def void shouldIncreaseSizeWhenNoValue() {
		prepareWithOutService(DummyService.name)
		val keysSizeBefore = ctx.keys.size
		val valuesSizeBefore = ctx.values.size

		ctx.set(DummyService, service)

		assertThat(ctx.keys.size - keysSizeBefore, equalTo(1))
		assertThat(ctx.values.size - valuesSizeBefore, equalTo(1))
	}

	@Test
	def void shouldNotIncreaseSizeWhenExistingValue() {
		prepareWithService(DummyService.name, service)
		val keysSizeBefore = ctx.keys.size
		val valuesSizeBefore = ctx.values.size

		ctx.set(DummyService, service)

		assertThat(ctx.keys.size, equalTo(keysSizeBefore))
		assertThat(ctx.values.size, equalTo(valuesSizeBefore))
	}

	@Test
	def void shouldChangeExistingValue() {
		prepareWithService(DummyService.name, service)
		val keyIndex = ctx.keys.indexOf(DummyService.name)
		val newService = new DummyService

		ctx.set(DummyService, newService)

		assertThat(ctx.keys.get(keyIndex), equalTo(DummyService.name))
		assertThat(ctx.values.get(keyIndex), not(service))
		assertThat(ctx.values.get(keyIndex), equalTo(newService))
	}

	@Test
	def void shouldKeyEqualsToClassName() {
		prepareWithOutService(DummyService.name)
		ctx.set(DummyService, service)
		val keyIndex = ctx.keys.indexOf(DummyService.name)

		assertThat(ctx.keys.get(keyIndex), equalTo(DummyService.name))
	}

	def private void checkSameSize() {
		if (ctx.keys.size != ctx.values.size) {
			fail("Key and value sizes not match. Testing on corrupted context")
		}
	}

	def private void prepareWithService(String key, Object service) {
		checkSameSize
		val keyIndex = ctx.keys.indexOf(key)
		if (keyIndex == -1) {
			ctx.keys.add(key)
			ctx.values.add(service)
		} else {
			ctx.values.add(keyIndex, service)
		}
		checkSameSize
	}

	def private void prepareWithOutService(String key) {
		checkSameSize
		val keyIndex = ctx.keys.indexOf(key)
		if (keyIndex != -1) {
			ctx.keys.remove(keyIndex)
			ctx.values.remove(keyIndex)
		}
		checkSameSize
	}

}