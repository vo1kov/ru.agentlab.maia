package ru.agentlab.maia.memory.injector.test.unit.doubles

import javax.inject.Inject

class FakeService_fieldsWithInject {

	@Inject
	var public byte byteField

	@Inject
	var public short shortField

	@Inject
	var public int intField

	@Inject
	var public long longField

	@Inject
	var public float floatField

	@Inject
	var public double doubleField

	@Inject
	var public char charField

	@Inject
	var public boolean booleanField

	@Inject
	var public DummyObject referenceField

	def public static getExpectedKeys() {
		return #[
			Byte,
			Short,
			Integer,
			Long,
			Float,
			Double,
			Character,
			Boolean,
			DummyObject
		].toArray
	}

}