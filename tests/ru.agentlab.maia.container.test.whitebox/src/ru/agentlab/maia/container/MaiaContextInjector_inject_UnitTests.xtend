package ru.agentlab.maia.container

import java.lang.reflect.Field
import javax.inject.Inject
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithDifferentVisibility
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.context.test.whitebox.doubles.FakeService_fieldsWithInjectNamed

import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class MaiaContextInjector_inject_UnitTests {

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

	val Object[] keys

	val Object[] values

	val Object service

	@Parameters(name="service:{0}")
	def public static getParams() {
		return #[
			#[
				new FakeService_fieldsWithDifferentVisibility,
				FakeService_fieldsWithDifferentVisibility.expectedKeys,
				FakeService_fieldsWithDifferentVisibility.fakeValues
			].toArray,
			#[
				new FakeService_fieldsWithInject,
				FakeService_fieldsWithInject.expectedKeys,
				FakeService_fieldsWithInject.fakeValues
			].toArray,
			#[
				new FakeService_fieldsWithInjectNamed,
				FakeService_fieldsWithInjectNamed.expectedKeys,
				FakeService_fieldsWithInjectNamed.fakeValues
			].toArray
		]
	}

	new(Object service, Object[] keys, Object[] values) {
		this.service = service
		this.keys = keys
		this.values = values
	}

	@Test
	def void test() {
		when(container.resolveKeys(anyCollectionOf(Field))).thenReturn(keys)
		when(container.resolveValues(anyCollectionOf(Object))).thenReturn(values)

		container.inject(service)

		val fields = service.class.declaredFields.filter[isAnnotationPresent(Inject)]
		val fieldValues = fields.map [
			val wasAccessible = isAccessible
			accessible = true
			val result = get(service)
			if (!wasAccessible) {
				accessible = false
			}
			return result
		]
		assertArrayEquals(values, fieldValues)
	}

}
