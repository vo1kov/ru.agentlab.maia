package ru.agentlab.maia.memory.injector.test.unit.doubles

import java.util.Random
import java.util.UUID
import javax.inject.Inject
import javax.inject.Named

import static org.mockito.Mockito.*

class FakeService_fieldsWithInjectNamed {

	val static random = new Random

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

	def public static getFakeValues() {
		return #[
			new Byte(random.nextInt as byte),
			new Short(random.nextInt as short),
			new Integer(random.nextInt as int),
			new Long(random.nextLong as long),
			new Float(random.nextFloat as float),
			new Double(random.nextDouble as double),
			UUID.randomUUID.toString.charAt(0) as char,
			new Boolean(random.nextBoolean as boolean),
			mock(DummyObject)
		].toArray
	}

}