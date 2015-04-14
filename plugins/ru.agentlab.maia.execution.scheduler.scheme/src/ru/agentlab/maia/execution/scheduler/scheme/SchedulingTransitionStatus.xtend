package ru.agentlab.maia.execution.scheduler.scheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class SchedulingTransitionStatus extends SchedulingTransition {

	int status

	new(int status, String name, IMaiaContextSchedulerState fromState, IMaiaContextSchedulerState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}