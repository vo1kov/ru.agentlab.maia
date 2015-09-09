package ru.agentlab.maia.memory.context.test.unit

import java.util.ArrayList
import java.util.Collection
import java.util.UUID
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.doubles.DummyService

abstract class VariableSizeCotextTests<T> {

	val static contextSizes = #[0, 1, 2, 5, 10, 100]

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

	def T getContext()
}