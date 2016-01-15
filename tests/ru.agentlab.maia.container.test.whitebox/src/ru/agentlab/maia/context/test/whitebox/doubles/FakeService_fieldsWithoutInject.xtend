package ru.agentlab.maia.context.test.whitebox.doubles

class FakeService_fieldsWithoutInject {

	var public byte byteField

	var public short shortField

	var public int intField

	var public long longField

	var public float floatField

	var public double doubleField

	var public char charField

	var public boolean booleanField

	var public DummyObject referenceField

	def public static getExpectedKeys() {
		return newArrayOfSize(0)
	}

	def public static getFakeValues() {
		return newArrayOfSize(0)
	}

}