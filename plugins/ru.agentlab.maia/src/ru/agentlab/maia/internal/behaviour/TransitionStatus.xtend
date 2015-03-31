package ru.agentlab.maia.internal.behaviour

import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionState

@Accessors(AccessorType.PUBLIC_GETTER)
class TransitionStatus extends ActionTransition {

	int status

	new(int status, String name, IActionState fromState, IActionState toState) {
		super(name, fromState, toState)
		this.status = status
	}

}