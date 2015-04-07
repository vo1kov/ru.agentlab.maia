package org.maia.task.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.task.scheduler.scheme.IBehaviourState

@Accessors
abstract class BehaviourState implements IBehaviourState {

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