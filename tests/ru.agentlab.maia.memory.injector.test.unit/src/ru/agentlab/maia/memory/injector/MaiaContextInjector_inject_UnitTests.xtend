package ru.agentlab.maia.memory.injector

import java.lang.reflect.Field
import javax.inject.Inject
import org.junit.Test
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithDifferentVisibility

import static org.junit.Assert.*
import static org.mockito.Matchers.*
import static org.mockito.Mockito.*

class MaiaContextInjector_inject_UnitTests {

	val context = mock(IMaiaContext)

	val injector = spy(new MaiaContextInjector(context))

	@Test
	def void test() {
		val object = new FakeService_fieldsWithDifferentVisibility
		val keys = FakeService_fieldsWithDifferentVisibility.expectedKeys
		val values = FakeService_fieldsWithDifferentVisibility.fakeValues
		when(injector.resolveKeys(anyCollectionOf(Field))).thenReturn(keys)
		when(injector.resolveValues(anyCollectionOf(Object))).thenReturn(values)
		val fields = object.class.declaredFields.filter[isAnnotationPresent(Inject)]
		val fieldValues = fields.map [
			val wasAccessible = isAccessible
			accessible = true
			val result = get(object)
			if (!wasAccessible) {
				accessible = false
			}
			return result
		]

		injector.inject(object)

		assertArrayEquals(values, fieldValues)
	}

}