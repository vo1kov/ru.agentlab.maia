package ru.agentlab.maia.memory.context.arraylist.test

import ru.agentlab.maia.memory.context.arraylist.ArrayContext
import javax.inject.Provider

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