package ru.agentlab.maia.memory.context.arraylist.separated.test.func

import ru.agentlab.maia.memory.context.arraylist.separated.SeparatedArrayListContext
import ru.agentlab.maia.memory.doubles.DummyService

class Main {

	def static void main(String[] args) {
		val context = new SeparatedArrayListContext
		val service = new DummyService
		context.set(DummyService, service)
		val s = context.get(DummyService)
	}

}