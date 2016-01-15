package ru.agentlab.maia.container

import org.junit.Test
import org.junit.runner.RunWith
import org.junit.runners.Parameterized
import org.junit.runners.Parameterized.Parameters
import ru.agentlab.maia.context.test.whitebox.doubles.DummyObject

import static org.hamcrest.Matchers.*
import static org.junit.Assert.*
import ru.agentlab.maia.container.Container

@RunWith(Parameterized)
class MaiaContextInjector_getBoxedType_UnitTests {

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

	val Class<?> inputType

	val Class<?> expectedOutput

	@Parameters(name="type: {0}, expected: {1}")
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
			#[Byte, Byte].toArray,
			#[Short, Short].toArray,
			#[Integer, Integer].toArray,
			#[Long, Long].toArray,
			#[Float, Float].toArray,
			#[Double, Double].toArray,
			#[Character, Character].toArray,
			#[Boolean, Boolean].toArray,
			#[DummyObject, DummyObject].toArray,
			#[String, String].toArray,
			#[Object, Object].toArray
		].toArray
	}

	new(Class<?> inputType, Class<?> expectedOutput) {
		this.inputType = inputType
		this.expectedOutput = expectedOutput
	}

	@Test
	def void self_returnExpectedValues() {
		assertThat(container.getBoxedType(inputType), equalTo(expectedOutput))
	}

}
