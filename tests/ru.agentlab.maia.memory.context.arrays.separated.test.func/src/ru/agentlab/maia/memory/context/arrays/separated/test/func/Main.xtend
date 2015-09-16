package ru.agentlab.maia.memory.context.arrays.separated.test.func

import ru.agentlab.maia.memory.context.arrays.separated.SeparatedArraysContext
import ru.agentlab.maia.memory.doubles.DummyService

class Main {

	def static void main(String[] args) {
		val context = new SeparatedArraysContext
		val service = new DummyService
		context.putService(DummyService, service)
		val s = context.getService(DummyService)
	}

}