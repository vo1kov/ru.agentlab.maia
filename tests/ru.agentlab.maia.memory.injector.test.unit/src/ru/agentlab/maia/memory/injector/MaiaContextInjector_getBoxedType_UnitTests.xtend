package ru.agentlab.maia.memory.injector

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.memory.injector.test.unit.doubles.DummyObject

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*

@RunWith(Parameterized)
class MaiaContextInjector_getBoxedType_UnitTests {

	val injector = new MaiaContextInjector(null)

	val Class<?> inputType

	val Class<?> expectedOutput

	@Parameters(name="type:{0}, expected:{1}")
	def public static getParams() {
		return #[
			#[byte, Byte].toArray,
			#[short, Short].toArray,
			#[int, Integer].toArray,
			#[long, Long].toArray,
			#[float, Float].toArray,
			#[double, Double].toArray,
			#[char, Character].toArray,
			#[boolean, Boolean].toArray,
			#[DummyObject, DummyObject].toArray
		].toArray
	}

	new(Class<?> inputType, Class<?> expectedOutput) {
		this.inputType = inputType
		this.expectedOutput = expectedOutput
	}

	@Test
	def void self_returnExpectedValues() {

		val actual = injector.getBoxedType(inputType)

		assertThat(actual, equalTo(expectedOutput))
	}
}