package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.IMaiaContext

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Mockito.*

abstract class AbstractContextTests {

	@Test
	def void shouldHaveUuid() {
		val uuid = context.uuid

		assertThat(uuid, notNullValue)
	}

	@Test
	def void shouldRetrieveServiceByClass() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceByName() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceByClassIfServiceInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.get(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceByNameIfServiceInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceByClassLocallyIfServiceInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldRetrieveServiceByNameLocallyIfServiceInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.getLocal(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldNotRetrieveServiceByClassLocallyIfServiceInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.getLocal(DummyService)

		assertThat(stored, nullValue)
	}

	@Test
	def void shouldNotRetrieveServiceByNameLocallyIfServiceInParent() {
		val service = new DummyService
		context.addParentWithService(service)

		val stored = context.getLocal(DummyService.name)

		assertThat(stored, nullValue)
	}

	def private IMaiaContext addParentWithService(IMaiaContext child, DummyService service) {
		val parent = mock(IMaiaContext)
		when(parent.get(DummyService)).thenReturn(service)
		when(parent.get(DummyService.name)).thenReturn(service)
		when(child.parent).thenReturn(parent)
		return parent
	}

	def IMaiaContext getContext()

}