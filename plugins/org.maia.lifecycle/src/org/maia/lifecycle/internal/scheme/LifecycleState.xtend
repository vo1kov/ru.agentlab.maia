package org.maia.lifecycle.internal.scheme

import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.lifecycle.scheme.ILifecycleState

@Accessors
class LifecycleState implements ILifecycleState {

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