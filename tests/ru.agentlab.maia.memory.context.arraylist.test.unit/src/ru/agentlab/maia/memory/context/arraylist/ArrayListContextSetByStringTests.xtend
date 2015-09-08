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
class ArrayListContextSetByStringTests {

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
		ctx.set(DummyService.name, service)

		assertThat(ctx.keys.size, equalTo(ctx.values.size))
	}

}