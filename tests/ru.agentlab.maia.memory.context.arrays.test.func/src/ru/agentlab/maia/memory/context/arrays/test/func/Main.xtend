package ru.agentlab.maia.memory.context.arrays.test.func

import javax.inject.Provider
import ru.agentlab.maia.memory.context.arrays.ArrayContext

class Main {

	def static void main(String[] args) {
		val ctx = new ArrayContext
		ctx.putProvider(String, new Provider<String> {

			override get() {
				"xxx"
			}

		})
		println(ctx.getService(String))
		ctx.putProvider(String, null as Provider<String>)
		println(ctx.getProvider(String))
	}

}