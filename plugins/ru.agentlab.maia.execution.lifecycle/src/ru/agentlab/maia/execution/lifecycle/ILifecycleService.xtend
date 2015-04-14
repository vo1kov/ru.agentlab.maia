package ru.agentlab.maia.execution.lifecycle

interface ILifecycleService {

	def ILifecycleScheme getScheme()

	def ILifecycleState getCurrentState()

	def void invokeTransition(ILifecycleTransition transition) throws IllegalStateException

	def void invokeTransition(String transition) throws IllegalStateException

	def void setState(String state) throws IllegalStateException

	def void setState(ILifecycleState state) throws IllegalStateException

}