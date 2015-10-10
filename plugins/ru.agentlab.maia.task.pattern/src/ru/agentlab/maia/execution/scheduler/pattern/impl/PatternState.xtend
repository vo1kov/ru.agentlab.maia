package ru.agentlab.maia.execution.scheduler.pattern.impl

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.ITask
import ru.agentlab.maia.execution.scheduler.pattern.IPatternState

@Accessors
class PatternState implements IPatternState {

	String name

	ITask node

	new(String name) {
		this.name = name
	}

}