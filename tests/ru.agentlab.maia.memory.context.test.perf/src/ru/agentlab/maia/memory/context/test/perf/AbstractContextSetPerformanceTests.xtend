package ru.agentlab.maia.memory.context.test.perf

import java.io.PrintWriter
import java.util.UUID
import org.junit.Test
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextSetPerformanceTests {

	@Test
	def void test() {
		val size = 1000
		val ctxSizeBefore = context.keySet.size
		val writer = new PrintWriter('''«this.class.simpleName»_perf2.csv''', "UTF-8")
		for (i : 0 ..< size) {
			val key = UUID.randomUUID.toString
			val service = new DummyService

			val begin = System.nanoTime
			context.set(key, service)
			val end = System.nanoTime

			writer.println(end - begin)
		}
		writer.close
		val ctxSizeAfter = context.keySet.size

		assertThat(ctxSizeAfter - ctxSizeBefore, equalTo(size))
	}

	def IMaiaContext getContext()

}