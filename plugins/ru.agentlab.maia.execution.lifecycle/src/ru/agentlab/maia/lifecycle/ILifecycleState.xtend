package ru.agentlab.maia.lifecycle

interface ILifecycleState {

	val static public ILifecycleState STATE_UNKNOWN = new ILifecycleState {

		override getName() {
			"UNKNOWN"
		}

		override toString() {
			return name
		}

	}

	def String getName()

}