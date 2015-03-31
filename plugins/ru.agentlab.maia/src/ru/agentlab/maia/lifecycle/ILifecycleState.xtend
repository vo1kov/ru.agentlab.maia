package ru.agentlab.maia.lifecycle

import ru.agentlab.maia.internal.lifecycle.LifecycleState

interface ILifecycleState {

	val static public STATE_UNKNOWN = new LifecycleState("UNKNOWN")

	def String getName()

}