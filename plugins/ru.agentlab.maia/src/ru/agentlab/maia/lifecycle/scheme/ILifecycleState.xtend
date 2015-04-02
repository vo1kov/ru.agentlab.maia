package ru.agentlab.maia.lifecycle.scheme

interface ILifecycleState {

	val static public ILifecycleState STATE_UNKNOWN = new ILifecycleState {

		override getName() {
			"UNKNOWN"
		}

	}

	def String getName()

}