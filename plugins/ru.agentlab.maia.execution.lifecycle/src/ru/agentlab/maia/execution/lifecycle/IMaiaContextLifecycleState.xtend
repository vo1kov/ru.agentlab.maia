package ru.agentlab.maia.execution.lifecycle

interface IMaiaContextLifecycleState {

	val static public IMaiaContextLifecycleState STATE_UNKNOWN = new IMaiaContextLifecycleState {

		override getName() {
			"UNKNOWN"
		}

		override toString() {
			return name
		}

	}

	def String getName()

}