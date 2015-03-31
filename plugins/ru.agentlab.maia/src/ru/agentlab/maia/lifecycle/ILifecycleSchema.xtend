package ru.agentlab.maia.lifecycle

import java.util.List

interface ILifecycleSchema {

	def ILifecycleState getInitialState()

	def ILifecycleState getFinalState()

	def List<ILifecycleState> getStates()

	def List<ILifecycleTransition> getTransitions()

}