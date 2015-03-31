package ru.agentlab.maia.agent

import org.eclipse.e4.core.contexts.IEclipseContext

interface ISchedulerFactory {

	def IScheduler create(IEclipseContext context)
}
