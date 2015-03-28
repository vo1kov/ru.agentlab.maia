package ru.agentlab.maia.context

import org.eclipse.e4.core.contexts.IEclipseContext

interface IContextFactory {

	val static String KEY_NAME = "name"

	val static String KEY_TYPE = "type"

	val static String KEY_PLATFORMS = "platforms"

	val static String KEY_CONTAINERS = "containers"

	val static String KEY_AGENTS = "agents"

	val static String KEY_BEHAVIOURS = "behaviours"

	val static String TYPE_PLATFORM = "ru.agentlab.maia.platform"

	val static String TYPE_CONTAINER = "ru.agentlab.maia.container"

	val static String TYPE_AGENT = "ru.agentlab.maia.agent"

	val static String TYPE_BEHAVIOUR = "ru.agentlab.maia.behaviour"

	def IEclipseContext createDefault(IEclipseContext root, String id)

	def IEclipseContext createEmpty(IEclipseContext root, String id)

}