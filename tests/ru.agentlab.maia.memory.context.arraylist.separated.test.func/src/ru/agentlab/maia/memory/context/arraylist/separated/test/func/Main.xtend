package ru.agentlab.maia.memory.context.arraylist.separated.test.func

import ru.agentlab.maia.memory.doubles.DummyService
import ru.agentlab.maia.memory.context.arraylist.separated.SeparatedArraysContext

class Main {

	def static void main(String[] args) {
		val context = new SeparatedArraysContext
		val service = new DummyService
		context.putService(DummyService, service)
		val s = context.getService(DummyService)
	}

}