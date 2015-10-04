package ru.agentlab.maia.execution.scheduler.fsm.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.scheduler.fsm.IFsmTransition

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	ITask from

	ITask to

	new(ITask from, ITask to) {
		this.from = from
		this.to = to
	}

}