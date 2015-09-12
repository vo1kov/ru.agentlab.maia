package ru.agentlab.maia.memory.context.maplisthybrid.test.func

import ru.agentlab.maia.memory.context.maplisthybrid.MapListContext
import ru.agentlab.maia.memory.doubles.DummyService

class Main {

	def static void main(String[] args) {
		val context = new MapListContext
		val service = new DummyService
		context.set(DummyService, service)
		val s = context.get(DummyService)
	}

}