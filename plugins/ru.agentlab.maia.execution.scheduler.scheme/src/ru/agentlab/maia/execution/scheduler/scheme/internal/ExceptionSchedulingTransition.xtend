package ru.agentlab.maia.execution.scheduler.scheme.internal

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*
import ru.agentlab.maia.execution.scheduler.scheme.ISchedulingState

@Accessors(AccessorType.PUBLIC_GETTER)
class ExceptionSchedulingTransition extends SchedulingTransition {

	Class<? extends Throwable> throwable

	new(Class<? extends Throwable> throwable, String name, ISchedulingState fromState, ISchedulingState toState) {
		super(name, fromState, toState)
		this.throwable = throwable
	}

	new(Class<? extends Throwable> throwable, ISchedulingState fromState, ISchedulingState toState) {
		super(throwable.class.name, fromState, toState)
		this.throwable = throwable
	}
}