package ru.agentlab.maia.execution.lifecycle

import java.util.List

interface IMaiaContextLifecycleScheme {

	def IMaiaContextLifecycleState getInitialState()

	def IMaiaContextLifecycleState getFinalState()

	def List<IMaiaContextLifecycleState> getStates()

	def List<IMaiaContextLifecycleTransition> getTransitions()

}