package ru.agentlab.maia.internal.naming

import java.util.List
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.naming.IContainerNameGenerator
import ru.agentlab.maia.context.IContextFactory

class ContainerNameGenerator implements IContainerNameGenerator {

	override generate(IEclipseContext context) {
		val platform = context.getPlatformContext
		if (platform != null) {
			val containers = platform.get(IContextFactory.KEY_CONTAINERS) as List<IEclipseContext>
			if(containers != null){
				// TODO: make sure that name unique
				val count = containers.size + 1
				return "Container_" + count
			} else {
				return "Container_0"
			}
		} else {
			return "Container"
		}
	}
	
	def IEclipseContext getPlatformContext(IEclipseContext context){
		var current = context 
		while(current != null){
			if(current.get(IContextFactory.KEY_TYPE).equals(IContextFactory.TYPE_PLATFORM)){
				return current
			}
			current = current.parent
		}
		return null
	}

}