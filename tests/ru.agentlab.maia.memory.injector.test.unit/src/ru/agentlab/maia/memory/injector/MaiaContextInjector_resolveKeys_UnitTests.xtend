package ru.agentlab.maia.memory.injector

import javax.inject.Inject
import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithDifferentVisibility
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInject
import ru.agentlab.maia.memory.injector.test.unit.doubles.FakeService_fieldsWithInjectNamed

import static org.junit.Assert.*

@RunWith(Parameterized)
class MaiaContextInjector_resolveKeys_UnitTests {

	val injector = new MaiaContextInjector(null)

	val Object service

	val Object[] expected

	@Parameters(name="service:{2}")
	def public static getParams() {
		return #[
			#[
				new FakeService_fieldsWithDifferentVisibility,
				FakeService_fieldsWithDifferentVisibility.expectedKeys,
				FakeService_fieldsWithDifferentVisibility.simpleName
			].toArray,
			#[
				new FakeService_fieldsWithInject,
				FakeService_fieldsWithInject.expectedKeys,
				FakeService_fieldsWithInject.simpleName
			].toArray,
			#[
				new FakeService_fieldsWithInjectNamed,
				FakeService_fieldsWithInjectNamed.expectedKeys,
				FakeService_fieldsWithInjectNamed.simpleName
			].toArray
		]
	}

	new(Object service, Object[] expected, String description) {
		this.service = service
		this.expected = expected
	}

	@Test
	def void self_returnExpectedValues() {
		val fields = service.class.declaredFields.filter[isAnnotationPresent(Inject)]

		val actual = injector.resolveKeys(fields)

		assertArrayEquals(expected, actual)
	}
}