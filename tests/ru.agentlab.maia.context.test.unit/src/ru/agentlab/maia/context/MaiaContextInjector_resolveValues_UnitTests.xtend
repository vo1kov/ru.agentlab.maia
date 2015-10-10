package ru.agentlab.maia.context

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import org.mockito.Matchers
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.Injector
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInjectNamed

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class MaiaContextInjector_resolveValues_UnitTests {

	val context = mock(IContext)

	val injector = new Injector(context)

	val Object service

	val Object[] keys

	@Parameters(name="service:{0}")
	def public static getParams() {
		return #[
			#[
				new FakeService_fieldsWithInject,
				FakeService_fieldsWithInject.expectedKeys
			].toArray,
			#[
				new FakeService_fieldsWithInjectNamed,
				FakeService_fieldsWithInjectNamed.expectedKeys
			].toArray
		]
	}

	new(Object service, Object[] expected) {
		this.service = service
		this.keys = expected
	}

	@Test
	def void self_callContextGetServiceByClass() {
		val keys = FakeService_fieldsWithInject.expectedKeys

		injector.resolveValues(keys)

		verify(context, times(keys.length)).getService(Matchers.any(Class))
	}

	@Test
	def void self_callContextGetServiceByString() {
		val keys = FakeService_fieldsWithInjectNamed.expectedKeys

		injector.resolveValues(keys)

		verify(context, times(keys.length)).getService(anyString)
	}

	@Test
	def void context_unchanged() {
		val before = injector.context

		injector.resolveValues(FakeService_fieldsWithInjectNamed.expectedKeys)

		assertThat(injector.context, equalTo(before))
	}
}