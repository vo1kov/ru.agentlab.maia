package ru.agentlab.maia.container

import javax.inject.Inject
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInjectNamed

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class MaiaContextInjector_resolveKeys_UnitTests {

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

	val Object[] expected

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
		this.expected = expected
	}

	@Test
	def void self_returnExpectedValues() {
		val fields = service.class.declaredFields.filter[isAnnotationPresent(Inject)]

		val actual = container.resolveKeys(fields)

		assertArrayEquals(expected, actual)
	}

}