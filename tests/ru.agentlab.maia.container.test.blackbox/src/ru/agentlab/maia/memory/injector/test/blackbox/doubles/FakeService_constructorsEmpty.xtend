package ru.agentlab.maia.memory.injector.test.blackbox.doubles

class FakeService_constructorsEmpty {

	public boolean constructorCalled = false
	
	new() {
		constructorCalled = true
	}

}