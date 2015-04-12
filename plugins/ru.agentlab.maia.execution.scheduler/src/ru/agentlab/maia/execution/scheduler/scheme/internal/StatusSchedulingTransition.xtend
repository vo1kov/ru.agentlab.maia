package ru.agentlab.maia.execution.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

@Accessors(AccessorType.PUBLIC_GETTER)
class StatusSchedulingTransition extends SchedulingTransition {

	int status

	new(int status, String name, ISchedulingState fromState, ISchedulingState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}