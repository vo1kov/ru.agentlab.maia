package ru.agentlab.maia.memory.injector.test.unit.doubles

import javax.inject.Inject
import javax.inject.Named

class FakeService_fieldsWithInjectNamed {

	@Inject @Named("byte")
	var public byte byteField

	@Inject @Named("short")
	var public short shortField

	@Inject @Named("int")
	var public int intField

	@Inject @Named("long")
	var public long longField

	@Inject @Named("float")
	var public float floatField

	@Inject @Named("double")
	var public double doubleField

	@Inject @Named("char")
	var public char charField

	@Inject @Named("boolean")
	var public boolean booleanField

	@Inject @Named("DummyObject")
	var public DummyObject referenceField

	def public static getExpectedKeys() {
		return #[
			"byte",
			"short",
			"int",
			"long",
			"float",
			"double",
			"char",
			"boolean",
			"DummyObject"
		].toArray
	}

}