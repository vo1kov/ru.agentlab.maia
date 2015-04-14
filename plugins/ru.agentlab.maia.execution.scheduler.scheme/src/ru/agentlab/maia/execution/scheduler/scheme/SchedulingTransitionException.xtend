package ru.agentlab.maia.execution.scheduler.scheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class SchedulingTransitionException extends SchedulingTransition {

	Class<? extends Throwable> throwable

	new(Class<? extends Throwable> throwable, String name, IMaiaContextSchedulerState fromState, IMaiaContextSchedulerState toState) {
		super(name, fromState, toState)
		this.throwable = throwable
	}

	new(Class<? extends Throwable> throwable, IMaiaContextSchedulerState fromState, IMaiaContextSchedulerState toState) {
		super(throwable.class.name, fromState, toState)
		this.throwable = throwable
	}
}