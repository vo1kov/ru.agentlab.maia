package ru.agentlab.maia.memory.doubles.constructors

class DummyServiceWithManyConstructors {

	public String s

	new(String s) {
		this.s = s
		firstConstructorCall
	}

	new(Integer i, String s) {
		this.s = s + i.toString
		secondConstructorCall
	}

	def void firstConstructorCall() {
	}

	def void secondConstructorCall() {
	}

}