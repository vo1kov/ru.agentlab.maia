package ru.agentlab.maia.memory.injector.test.unit.doubles

import javax.inject.Named

class FakeService_parametersWithNamed {

	def void byteMethod(@Named("byte") byte byteField) {}

	def void shortMethod(@Named("short") short shortField) {}

	def void intMethod(@Named("integer") int intField) {}

	def void longMethod(@Named("long") long longField) {}

	def void floatMethod(@Named("float") float floatField) {}

	def void doubleMethod(@Named("double") double doubleField) {}

	def void charMethod(@Named("char") char charField) {}

	def void booleanMethod(@Named("boolean") boolean booleanField) {}

	def void referenceMethod(@Named("DummyObject") DummyObject referenceField) {}

}