package ru.agentlab.maia.memory.context.hashmap.test

import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Test
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.context.hashmap.HashMapContext
import ru.agentlab.maia.memory.doubles.hierarchy.DummyChildService
import ru.agentlab.maia.memory.doubles.hierarchy.DummyParentService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

class HashMapContextGetLocalByClassTests {

	@Accessors
	IMaiaContext context = spy(new HashMapContext)

	@Test
	def void shouldRetrieveServiceFromClassHierarchy() {
		val service = new DummyChildService
		context.set(DummyChildService, service)

		val stored = context.getLocal(DummyParentService)

		assertThat(stored, equalTo(service))
	}

}