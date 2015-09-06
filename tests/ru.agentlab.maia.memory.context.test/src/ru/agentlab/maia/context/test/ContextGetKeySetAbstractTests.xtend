package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.memory.test.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class ContextGetKeySetAbstractTests extends ContextAbstractTests {

	@Test
	def void shouldContainKey() {
		context.set(DummyService, new DummyService)

		val keySet = context.keySet

		assertThat(keySet, containsInAnyOrder(#[DummyService.name]))
	}
	
	@Test
	def void shouldNotChangeKeySetWhenAddDuplicate() {
		context.set(DummyService, new DummyService)
		val beforeSize = context.keySet.size
		
		context.set(DummyService, new DummyService)
		val afterSize = context.keySet.size

		assertThat(afterSize, equalTo(beforeSize))
	}
	
}