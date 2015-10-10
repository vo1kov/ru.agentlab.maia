package ru.agentlab.maia.context

import java.lang.reflect.Field
import javax.inject.Inject
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.context.IContext
import ru.agentlab.maia.context.Injector
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithDifferentVisibility
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInjectNamed

import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

@RunWith(Parameterized)
class MaiaContextInjector_inject_UnitTests {

	val context = mock(IContext)

	val injector = spy(new Injector(context))

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
		when(injector.resolveKeys(anyCollectionOf(Field))).thenReturn(keys)
		when(injector.resolveValues(anyCollectionOf(Object))).thenReturn(values)

		injector.inject(service)

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