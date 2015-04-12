package ru.agentlab.maia.execution.scheduler.scheme

interface ISchedulingTransition {

	def String getName()

	def ISchedulingState getFromState()

	def ISchedulingState getToState()

}