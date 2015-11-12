package ru.agentlab.maia.behaviour.fsm

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviour

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	IBehaviour from

	IBehaviour to

	new(IBehaviour from, IBehaviour to) {
		this.from = from
		this.to = to
	}

}