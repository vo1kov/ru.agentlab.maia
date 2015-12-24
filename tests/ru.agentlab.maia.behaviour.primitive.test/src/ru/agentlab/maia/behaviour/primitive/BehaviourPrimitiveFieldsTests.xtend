package ru.agentlab.maia.behaviour.primitive

import ru.agentlab.maia.behaviour.primitive.doubles.DummyActionEmpty
import ru.agentlab.maia.behaviour.primitive.doubles.DummyActionFields
import org.junit.Assert

class BehaviourPrimitiveFieldsTests {

	@org.junit.Test(expected=IllegalArgumentException)
	def void testEmptyAction() {
		val behaviour = new BehaviourPrimitiveFields
		behaviour.setImplementation = new DummyActionEmpty
	}

	@org.junit.Test
	def void testValidAction() {
		val behaviour = new BehaviourPrimitiveFields
		behaviour.setImplementation = new DummyActionFields
		
		Assert.assertEquals(behaviour.inputs.get(0).name, "field1")
		Assert.assertEquals(behaviour.outputs.get(0).name, "field2")
	}

}