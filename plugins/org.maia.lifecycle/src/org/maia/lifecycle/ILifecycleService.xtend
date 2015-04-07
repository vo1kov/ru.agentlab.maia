package org.maia.lifecycle

//import ru.agentlab.maia.lifecycle.scheme.ILifecycleScheme

import org.maia.lifecycle.scheme.ILifecycleScheme
import org.maia.lifecycle.scheme.ILifecycleState
import org.maia.lifecycle.scheme.ILifecycleTransition

interface ILifecycleService {

	def ILifecycleScheme getSchema()

	def ILifecycleState getCurrentState()

	def void invokeTransition(ILifecycleTransition transition) throws IllegalStateException

	def void invokeTransition(String transition) throws IllegalStateException

	def void setState(String state) throws IllegalStateException

	def void setState(ILifecycleState state) throws IllegalStateException

}