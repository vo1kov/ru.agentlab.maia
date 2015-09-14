package ru.agentlab.maia.memory.context.hashmap.test

import ru.agentlab.maia.memory.context.hashmap.HashMapContext
import ru.agentlab.maia.memory.doubles.DummyService

class Main {
	
	def static void main(String[] args) {
		val ctx = new HashMapContext
		ctx.putService(DummyService.name, new DummyService)
		ctx.putService(DummyService, new DummyService)
		println(ctx.getService(DummyService))
		println(ctx.getService(DummyService.name))
	}
	
}