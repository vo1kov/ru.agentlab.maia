package ru.agentlab.maia.execution.lifecycle

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class LifecycleState implements IMaiaContextLifecycleState {

	var String name

	new(String name) {
		this.name = name
	}

	override equals(Object obj) {
		if (obj instanceof LifecycleState) {
			return obj.name.equalsIgnoreCase(name)
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		return name
	}

}