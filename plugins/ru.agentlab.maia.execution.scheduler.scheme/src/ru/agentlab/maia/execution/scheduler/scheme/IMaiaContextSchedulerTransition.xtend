package ru.agentlab.maia.execution.scheduler.scheme

interface IMaiaContextSchedulerTransition {

	def String getName()

	def IMaiaContextSchedulerState getFromState()

	def IMaiaContextSchedulerState getToState()

}