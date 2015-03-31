package ru.agentlab.maia.behaviour.sheme

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviourState

@Accessors
class BehaviourState implements IBehaviourState {

	var String name

	new(String name) {
		this.name = name
	}

	override equals(Object obj) {
		if (obj instanceof BehaviourState) {
			return obj.name.equalsIgnoreCase(name)
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		return name
	}

}