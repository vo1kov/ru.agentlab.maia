package ru.agentlab.maia.context.test.performance

import java.io.PrintWriter
import java.util.UUID
import org.junit.Test
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.test.performance.doubles.DummyService

abstract class AbstractContextSetPerformanceTests {

	@Test
	def void test() {
		val totalSize = 10_000
		val bucketSize = 100
		val warmupCount = 5
		val keys = newArrayOfSize(totalSize)
		val services = newArrayOfSize(totalSize)
		val results = newArrayOfSize(totalSize / bucketSize)

		for (i : 0 ..< totalSize) {
			val key = UUID.randomUUID.toString
			keys.set(i, key)
			val service = new DummyService
			services.set(i, service)
		}
		// warm up
		for (c : 0 ..< warmupCount) {

			// test
			var index = 0
			for (i : 0 ..< totalSize / bucketSize) {
				val begin = System.nanoTime
				for (j : 0 ..< bucketSize) {
					context.put(keys.get(index), services.get(index))
					index++
				}
				results.set(i, System.nanoTime - begin)
			}
		}

		val writer = new PrintWriter('''target/results/«context.class.simpleName»_performance.csv''', "UTF-8")
		for (i : 0 ..< totalSize / bucketSize) {
			writer.println(results.get(i))
		}
		writer.close
	}

	def IContext getContext()

}