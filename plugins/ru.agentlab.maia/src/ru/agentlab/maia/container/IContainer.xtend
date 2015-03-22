package ru.agentlab.maia.container

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.platform.IPlatform

interface IContainer {

	val static String KEY_STATE = "container.state"

	val static String KEY_NAME = "container.name"

	val static String KEY_CONTRIBUTOR = "container.contributor"

	def IEclipseContext getContext()

	def List<IAgent> getChilds()

	def IPlatform getRoot()

	def IContainerId getId()

	def void setId(IContainerId id)

}