package ru.agentlab.maia.internal.behaviour

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionState
import org.eclipse.xtend.lib.annotations.AccessorType

@Accessors(AccessorType.PUBLIC_GETTER)
class TransitionException extends ActionTransition {

	Class<? extends Throwable> throwable

	new(Class<? extends Throwable> throwable, String name, IActionState fromState, IActionState toState) {
		super(name, fromState, toState)
		this.throwable = throwable
	}

	new(Class<? extends Throwable> throwable, IActionState fromState, IActionState toState) {
		super(throwable.class.name, fromState, toState)
		this.throwable = throwable
	}
}