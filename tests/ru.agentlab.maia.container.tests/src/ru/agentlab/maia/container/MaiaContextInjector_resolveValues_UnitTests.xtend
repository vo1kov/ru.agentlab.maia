package ru.agentlab.maia.container

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import org.mockito.Matchers
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInjectNamed

import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class MaiaContextInjector_resolveValues_UnitTests {

	val container = new Container {

		override protected getInternal(String key) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override protected getInternal(Class<?> key) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override protected putInternal(String key, Object value) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override protected putInternal(Class<?> key, Object value) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override protected removeInternal(String key) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override protected removeInternal(Class<?> key) {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override getKeySet() {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

		override clear() {
			throw new UnsupportedOperationException("TODO: auto-generated method stub")
		}

	}

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

		container.resolveValues(keys)

		verify(container, times(keys.length)).get(Matchers.any(Class))
	}

	@Test
	def void self_callContextGetServiceByString() {
		val keys = FakeService_fieldsWithInjectNamed.expectedKeys

		container.resolveValues(keys)

		verify(container, times(keys.length)).get(anyString)
	}

}
