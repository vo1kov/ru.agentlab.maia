package ru.agentlab.maia.internal.behaviour

import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviour

class Behaviour implements IBehaviour {

	@Accessors
	IEclipseContext context

	override getState() {
		return context.get(KEY_STATE) as String
	}
	
}