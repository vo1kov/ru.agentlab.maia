package ru.agentlab.maia.execution.scheduler.pattern.impl

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class ExceptionPatternTransition extends AbstractPatternTransition {

	Class<? extends RuntimeException> exception

	new(Class<? extends RuntimeException> exception, String name, PatternState fromState, PatternState toState) {
		super(name, fromState, toState)
		this.exception = exception
	}

	new(Class<? extends RuntimeException> exception, PatternState fromState, PatternState toState) {
		super(exception.class.name, fromState, toState)
		this.exception = exception
	}
}