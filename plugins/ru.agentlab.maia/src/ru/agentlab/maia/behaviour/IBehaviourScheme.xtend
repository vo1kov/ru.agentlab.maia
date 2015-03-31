package ru.agentlab.maia.behaviour

import java.util.List

interface IBehaviourScheme extends IBehaviourState {

	def IBehaviourState getInitialState()

	def IBehaviourState getFinalState()

	def List<IBehaviourState> getStates()

	def List<IBehaviourTransition> getTransitions()

}