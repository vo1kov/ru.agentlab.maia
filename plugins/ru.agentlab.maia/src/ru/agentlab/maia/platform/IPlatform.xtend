package ru.agentlab.maia.platform

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.container.IContainer

interface IPlatform {

	val static String KEY_STATE = "platform.state"

	val static String KEY_NAME = "platform.name"

	val static String KEY_CONTRIBUTOR = "platform.contributor"

	def IEclipseContext getContext()

	def IPlatformId getId()

	def List<IContainer> getChilds()

}