package ru.agentlab.maia.lifecycle

interface ILifecycleService {

	def ILifecycleSchema getSchema()

	def ILifecycleState getCurrentState()

	def void invokeTransition(ILifecycleTransition transition) throws IllegalStateException

	def void invokeTransition(String transition) throws IllegalStateException

	def void setState(String state) throws IllegalStateException

	def void setState(ILifecycleState state) throws IllegalStateException

}