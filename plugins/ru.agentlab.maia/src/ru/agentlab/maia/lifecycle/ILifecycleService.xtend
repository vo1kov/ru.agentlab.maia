package ru.agentlab.maia.lifecycle

import org.eclipse.e4.core.contexts.IEclipseContext

interface ILifecycleService {
	
	val static String KEY_STATE = "state"

	def String getState(IEclipseContext context)

	def void setState(IEclipseContext context, String state) throws IllegalStateException

	def Iterable<String> getPossibleStates()

	
	
}