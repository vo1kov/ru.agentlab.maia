package ru.agentlab.maia.context.test.whitebox.doubles

import java.util.Random
import javax.inject.Inject

import static org.mockito.Mockito.*

class FakeService_fieldsWithInject {

	val static random = new Random

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

	def public static getFakeValues() {
		return #[
			new Byte(random.nextInt as byte),
			new Short(random.nextInt as short),
			new Integer(random.nextInt as int),
			new Long(random.nextLong as long),
			new Float(random.nextFloat as float),
			new Double(random.nextDouble as double),
			new Character(random.nextInt as char),
			new Boolean(random.nextBoolean as boolean),
			mock(DummyObject)
		].toArray
	}
}