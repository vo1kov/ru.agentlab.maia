package org.maia.task.scheduler.scheme

import java.util.List

interface IBehaviourScheme extends IBehaviourState {

	def IBehaviourState getInitialState()

	def IBehaviourState getFinalState()

	def List<IBehaviourState> getStates()

	def List<IBehaviourTransition> getTransitions()
	
	def Object getDefaultTask(IBehaviourState state)

}