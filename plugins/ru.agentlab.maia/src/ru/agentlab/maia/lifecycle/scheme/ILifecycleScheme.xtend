package ru.agentlab.maia.lifecycle.scheme

import java.util.List

interface ILifecycleScheme {

	def ILifecycleState getInitialState()

	def ILifecycleState getFinalState()

	def List<ILifecycleState> getStates()

	def List<ILifecycleTransition> getTransitions()

}