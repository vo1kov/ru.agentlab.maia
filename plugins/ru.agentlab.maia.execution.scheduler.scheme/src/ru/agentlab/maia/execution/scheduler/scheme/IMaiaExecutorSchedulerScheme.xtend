package ru.agentlab.maia.execution.scheduler.scheme

import java.util.List

interface IMaiaExecutorSchedulerScheme {
	
	def String getName()

	def IMaiaContextSchedulerState getInitialState()
	
	def IMaiaContextSchedulerState getCurrentState()

	def IMaiaContextSchedulerState getFinalState()

	def List<IMaiaContextSchedulerState> getAllStates()

	def List<IMaiaContextSchedulerTransition> getAllTransitions()
	
	def IMaiaContextSchedulerState getNextState(Object status)

}