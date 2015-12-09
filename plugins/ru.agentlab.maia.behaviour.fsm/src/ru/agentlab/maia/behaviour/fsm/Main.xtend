package ru.agentlab.maia.behaviour.fsm

import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourException

class Main {
	def static void main(String[] args) {
		val IBehaviourException s = null
		switch (s) {
			IBehaviourException: {
				println(IBehaviourException)
			}
			IBehaviour: {
				println(IBehaviour)
			}
			default: {
				println("default")
			}
		}
	}
}
