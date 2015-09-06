package ru.agentlab.maia.memory.doubles.constructors

import javax.inject.Inject

class DummyServiceWithManyConstructors {

	public boolean firstConstructorCalled = false

	public boolean secondConstructorCalled = false

	public String stringValue

	public Integer intValue

	@Inject
	new(String s) {
		this.stringValue = s
		firstConstructorCalled = true
	}

	@Inject
	new(Integer i, String s) {
		this.stringValue = s
		this.intValue = i
		secondConstructorCalled = true
	}

}