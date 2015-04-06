package ru.agentlab.maia.internal.behaviour.scheme

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.sheme.IBehaviourState
import ru.agentlab.maia.TaskInput

@Accessors(AccessorType.PUBLIC_GETTER)
class BehaviourTransitionException extends BehaviourTransition {

	@TaskInput
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