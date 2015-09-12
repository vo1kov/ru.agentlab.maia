package ru.agentlab.maia.memory.context.test

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.doubles.DummyService

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class AbstractContext_SetByName_FunctionalTests extends AbstractContext_AbstractFunctionalTests {

	new(IMaiaContext context) {
		super(context)
	}

	@Test
	def void shouldAddServiceWhenNoInContext() {
		val service = new DummyService
		assertThat(context.get(DummyService.name), nullValue)

		context.set(DummyService.name, service)

		assertThat(context.get(DummyService.name), equalTo(service))
	}

	@Test
	def void shouldChangeServiceWhenInContext() {
		val serviceOld = new DummyService
		assertThat(context.get(DummyService.name), nullValue)
		context.set(DummyService.name, serviceOld)
		assertThat(context.get(DummyService.name), equalTo(serviceOld))
		val serviceNew = new DummyService

		context.set(DummyService.name, serviceNew)

		assertThat(context.get(DummyService.name), equalTo(serviceNew))
	}

	@Test
	def void shouldAddServiceLocallyWhenInParent() {
		val parentService = new DummyService
		val parent = context.addParentWithService(parentService)
		assertThat(context.get(DummyService.name), equalTo(parentService))
		val contextService = new DummyService

		context.set(DummyService.name, contextService)

		assertThat(parent.get(DummyService.name), equalTo(parentService))
		assertThat(context.get(DummyService.name), equalTo(contextService))
	}

	@Test(expected=NullPointerException)
	def void shouldThrowWhenNullKey() {
		context.set(null as String, new DummyService)
	}

	@Test
	def void shouldNullableServiceWhenNullValue() {
		context.set(DummyService.name, null)

		assertThat(context.get(DummyService.name), nullValue)
	}

	@Test
	def void shouldContainsKeyWhenNullValue() {
		context.set(DummyService.name, null)

		assertThat(context.keySet, containsInAnyOrder(#[DummyService.name]))
	}

}