package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextTests {

	@Test
	def void shouldHaveUuid() {
		val uuid = context.uuid

		assertThat(uuid, notNullValue)
	}
	
	@Test
	def void shouldStoreServices(){
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService)
		
		assertThat(stored, equalTo(service))
	}
	

	def IMaiaContext getContext()

}