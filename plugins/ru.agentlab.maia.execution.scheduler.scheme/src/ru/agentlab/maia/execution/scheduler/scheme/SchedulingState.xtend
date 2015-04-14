package ru.agentlab.maia.execution.scheduler.scheme

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class SchedulingState implements IMaiaContextSchedulerState {

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