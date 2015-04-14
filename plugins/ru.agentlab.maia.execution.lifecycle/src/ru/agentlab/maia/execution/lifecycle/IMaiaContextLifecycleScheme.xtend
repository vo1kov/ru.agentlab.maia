package ru.agentlab.maia.execution.lifecycle

import java.util.List

interface IMaiaContextLifecycleScheme {

	def ILifecycleState getInitialState()

	def ILifecycleState getFinalState()

	def List<ILifecycleState> getStates()

	def List<ILifecycleTransition> getTransitions()

}