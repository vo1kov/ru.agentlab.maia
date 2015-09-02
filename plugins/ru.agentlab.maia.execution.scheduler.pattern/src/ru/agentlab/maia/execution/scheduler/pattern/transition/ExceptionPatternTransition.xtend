package ru.agentlab.maia.execution.scheduler.pattern.transition

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.scheduler.pattern.state.PatternState

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

@Accessors(AccessorType.PUBLIC_GETTER)
class ExceptionPatternTransition extends AbstractPatternTransition {

	Class<? extends Throwable> throwable

	new(Class<? extends Throwable> throwable, String name, PatternState fromState, PatternState toState) {
		super(name, fromState, toState)
		this.throwable = throwable
	}

	new(Class<? extends Throwable> throwable, PatternState fromState, PatternState toState) {
		super(throwable.class.name, fromState, toState)
		this.throwable = throwable
	}
}