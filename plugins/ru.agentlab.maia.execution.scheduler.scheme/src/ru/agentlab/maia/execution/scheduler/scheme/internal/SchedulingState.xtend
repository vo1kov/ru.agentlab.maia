package ru.agentlab.maia.execution.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

@Accessors
class SchedulingState implements ISchedulingState {

	var String name

	new(String name) {
		this.name = name
	}

	override equals(Object obj) {
		if (obj instanceof SchedulingState) {
			return obj.name.equalsIgnoreCase(name)
		} else {
			super.equals(obj)
		}
	}

	override toString() {
		return name
	}

}