package ru.agentlab.maia.execution.scheduler.scheme

import java.util.List

interface ISchedulingScheme {
	
	def String getName()

	def ISchedulingState getInitialState()

	def ISchedulingState getFinalState()

	def List<ISchedulingState> getAllStates()

	def List<ISchedulingTransition> getAllTransitions()
	
	def ISchedulingState getNextState(Object status)

}