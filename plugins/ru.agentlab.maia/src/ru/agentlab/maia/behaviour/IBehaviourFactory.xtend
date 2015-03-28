package ru.agentlab.maia.behaviour

import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IContextFactory

interface IBehaviourFactory extends IContextFactory {

	def IEclipseContext createCyclyc(IEclipseContext root, String id)

	def IEclipseContext createOneShot(IEclipseContext root, String id)

	def IEclipseContext createTicker(IEclipseContext root, String id, long delay)

	def IEclipseContext createFromAnnotation(IEclipseContext root, String id, Class<?> contributorClass)
}