package ru.agentlab.maia.task.fsm

import ru.agentlab.maia.task.ITask

class DefaultFsmTransition extends AbstractFsmTransition {

	new(ITask from, ITask to) {
		super(from, to)
	}

}