package ru.agentlab.maia.internal.behaviour

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionState

@Accessors
class ActionState implements IActionState {

	var String name

	new(String name) {
		this.name = name
	}

	override equals(Object obj) {
		if (obj instanceof ActionState) {
			return obj.name.equalsIgnoreCase(name)
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		return name
	}

}