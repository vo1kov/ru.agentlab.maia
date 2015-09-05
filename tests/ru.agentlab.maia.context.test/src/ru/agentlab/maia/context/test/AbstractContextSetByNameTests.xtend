package ru.agentlab.maia.context.test

import org.junit.Test
import ru.agentlab.maia.context.test.internal.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*


abstract class AbstractContextSetByNameTests extends AbstractContextTests {

	@Test
	def void shouldAddServiceWhenNoInContext() {
		val service = new DummyService
		context.set(DummyService, service)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(service))
	}

	@Test
	def void shouldChangeServiceWhenInContext() {
		val serviceOld = new DummyService
		val serviceNew = new DummyService
		context.set(DummyService, serviceOld)
		context.set(DummyService, serviceNew)

		val stored = context.get(DummyService.name)

		assertThat(stored, equalTo(serviceNew))
	}

	@Test
	def void shouldAddServiceLocallyWhenInParent() {
		val parentService = new DummyService
		val parent = context.addParentWithService(parentService)
		
		val contextService = new DummyService
		context.set(DummyService, contextService)

		val storedParentService = parent.get(DummyService.name)
		val storedContextService = context.get(DummyService.name)

		assertThat(storedParentService, equalTo(parentService))
		assertThat(storedContextService, equalTo(contextService))
	}

}