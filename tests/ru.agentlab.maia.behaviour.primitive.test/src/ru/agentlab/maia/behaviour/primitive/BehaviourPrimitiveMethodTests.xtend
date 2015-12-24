package ru.agentlab.maia.behaviour.primitive

import org.junit.Assert
import org.junit.Test
import ru.agentlab.maia.behaviour.primitive.doubles.DummyActionEmpty
import ru.agentlab.maia.behaviour.primitive.doubles.DummyActionMethodObject
import ru.agentlab.maia.behaviour.primitive.doubles.DummyActionMethodVoid

class BehaviourPrimitiveMethodTests {

	@Test(expected=IllegalArgumentException)
	def void testEmptyAction() {
		val behaviour = new BehaviourPrimitiveMethod
		behaviour.setImplementation = new DummyActionEmpty
	}

	@Test
	def void testValidAction() {
		val behaviour = new BehaviourPrimitiveMethod

		behaviour.setImplementation = new DummyActionMethodObject

		Assert.assertEquals(behaviour.inputs.size, 2)
		Assert.assertEquals(behaviour.inputs.get(0).type, String)
		Assert.assertEquals(behaviour.inputs.get(1).type, Object)
		Assert.assertEquals(behaviour.outputs.size, 1)
		Assert.assertEquals(behaviour.outputs.get(0).type, Object)
	}

	@Test
	def void testVoidAction() {
		val behaviour = new BehaviourPrimitiveMethod
		behaviour.setImplementation = new DummyActionMethodVoid

		Assert.assertEquals(behaviour.outputs.size, 0)
	}

}