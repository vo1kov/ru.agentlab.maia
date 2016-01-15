package ru.agentlab.maia.context.test.performance

import com.javamex.classmexer.MemoryUtil
import java.io.PrintWriter
import java.util.UUID
import org.junit.Test
import ru.agentlab.maia.IContainer
import ru.agentlab.maia.context.test.performance.doubles.DummyService

abstract class AbstractContextSetMemoryTests {

	@Test
	def void test() {
		val totalSize = 1_000
		val results = newArrayOfSize(totalSize)

		for (i : 0 ..< totalSize) {
			context.put(UUID.randomUUID.toString, new DummyService)
			results.set(i, MemoryUtil.deepMemoryUsageOf(context))
		}

		val writer = new PrintWriter('''target/results/«context.class.simpleName»_memory.csv''', "UTF-8")
		for (i : 0 ..< totalSize) {
			writer.println(results.get(i))
		}
		writer.close
	}

	def IContainer getContext()

}
