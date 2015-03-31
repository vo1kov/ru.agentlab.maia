package ru.agentlab.maia.internal.behaviour

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionMapping
import ru.agentlab.maia.behaviour.IActionState

class ActionMapping implements IActionMapping {
	
	@Accessors
	val map = new HashMap<IActionState, Object>
	
	override get(IActionState state) {
		map.get(state)
	}
	
}