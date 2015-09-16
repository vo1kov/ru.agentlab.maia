package ru.agentlab.maia.memory.injector.test.func.doubles

class FakeService_constructorsEmpty {

	public boolean constructorCalled = false
	
	new() {
		constructorCalled = true
	}

}