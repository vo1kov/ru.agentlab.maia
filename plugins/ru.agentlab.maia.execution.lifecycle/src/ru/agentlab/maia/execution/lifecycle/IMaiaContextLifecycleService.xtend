package ru.agentlab.maia.execution.lifecycle

interface IMaiaContextLifecycleService {

	def IMaiaContextLifecycleScheme getScheme()

	def IMaiaContextLifecycleState getCurrentState()

	def void invokeTransition(IMaiaContextLifecycleTransition transition) throws IllegalStateException

	def void setState(IMaiaContextLifecycleState state) throws IllegalStateException

}