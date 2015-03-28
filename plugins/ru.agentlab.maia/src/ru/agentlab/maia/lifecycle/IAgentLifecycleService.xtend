package ru.agentlab.maia.lifecycle

import org.eclipse.e4.core.contexts.IEclipseContext

interface IAgentLifecycleService extends ILifecycleService {
	
	override void setState(IEclipseContext context, String state) throws IllegalAgentStateException
	
}