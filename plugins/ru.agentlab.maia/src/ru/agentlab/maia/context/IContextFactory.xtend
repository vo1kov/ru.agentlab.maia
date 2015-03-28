package ru.agentlab.maia.context

import org.eclipse.e4.core.contexts.IEclipseContext

interface IContextFactory {

	val static String KEY_NAME = "name"

	val static String KEY_TYPE = "type"

	def IEclipseContext createDefault(IEclipseContext root, String id)

	def IEclipseContext createEmpty(IEclipseContext root, String id)

}