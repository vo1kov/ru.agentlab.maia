package ru.agentlab.maia.memory.doubles.constructors

class DummyServiceWithEmptyConstructor {

	public boolean constructorCalled = false
	
	new() {
		constructorCalled = true
	}

}