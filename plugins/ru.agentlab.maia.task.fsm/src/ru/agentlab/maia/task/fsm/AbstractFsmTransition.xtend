package ru.agentlab.maia.task.fsm

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.task.ITask

@Accessors
abstract class AbstractFsmTransition implements IFsmTransition {

	ITask from

	ITask to

	new(ITask from, ITask to) {
		this.from = from
		this.to = to
	}

}