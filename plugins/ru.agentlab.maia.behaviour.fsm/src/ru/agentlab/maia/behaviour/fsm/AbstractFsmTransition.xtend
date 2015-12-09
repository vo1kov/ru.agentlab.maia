package ru.agentlab.maia.behaviour.fsm

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IExecutionStep

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	IExecutionStep from

	IExecutionStep to

	new(IExecutionStep from, IExecutionStep to) {
		this.from = from
		this.to = to
	}

}
