package ru.agentlab.maia.behaviour

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IContextFactory

interface IBehaviourFactory extends IContextFactory {

	def IEclipseContext createCyclyc(String id)

	def IEclipseContext createOneShot(String id)

	def IEclipseContext createTicker(String id, long delay)

	def IEclipseContext createFromAnnotation(String id, Class<?> contributorClass)
}