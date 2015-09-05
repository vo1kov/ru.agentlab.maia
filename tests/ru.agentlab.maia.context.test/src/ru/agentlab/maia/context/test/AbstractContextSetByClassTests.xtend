package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.test.internal.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

abstract class AbstractContextSetByClassTests extends AbstractContextTests {

	@Test
	def void shouldAddServiceWhenNoInContext() {
		val service = new DummyService
		assertThat(context.get(DummyService), nullValue)

		context.set(DummyService, service)

		assertThat(context.get(DummyService), equalTo(service))
	}

	@Test
	def void shouldChangeServiceWhenInContext() {
		val serviceOld = new DummyService
		assertThat(context.get(DummyService), nullValue)
		context.set(DummyService, serviceOld)
		assertThat(context.get(DummyService), equalTo(serviceOld))
		val serviceNew = new DummyService

		context.set(DummyService, serviceNew)

		assertThat(context.get(DummyService), equalTo(serviceNew))
	}

	@Test
	def void shouldAddServiceLocallyWhenInParent() {
		val parentService = new DummyService
		val parent = context.addParentWithService(parentService)
		assertThat(context.get(DummyService), equalTo(parentService))
		val contextService = new DummyService

		context.set(DummyService, contextService)

		assertThat(parent.get(DummyService), equalTo(parentService))
		assertThat(context.get(DummyService), equalTo(contextService))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.set(null as Class<DummyService>, new DummyService)
	}

	@Test
	def void shouldNullableServiceWhenNullValue() {
		context.set(DummyService, null)

		assertThat(context.get(DummyService), nullValue)
	}

	@Test
	def void shouldContainsKeyWhenNullValue() {
		context.set(DummyService, null)

		assertThat(context.keySet, containsInAnyOrder(#[DummyService.name]))
	}

}