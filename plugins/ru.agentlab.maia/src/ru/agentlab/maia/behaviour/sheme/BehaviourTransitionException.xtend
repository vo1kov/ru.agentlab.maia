package ru.agentlab.maia.behaviour.sheme

import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.AccessorType
import ru.agentlab.maia.behaviour.IBehaviourState

@Accessors(AccessorType.PUBLIC_GETTER)
class BehaviourTransitionException extends BehaviourTransition {

	Class<? extends Throwable> throwable

	new(Class<? extends Throwable> throwable, String name, IBehaviourState fromState, IBehaviourState toState) {
		super(name, fromState, toState)
		this.throwable = throwable
	}

	new(Class<? extends Throwable> throwable, IBehaviourState fromState, IBehaviourState toState) {
		super(throwable.class.name, fromState, toState)
		this.throwable = throwable
	}
}