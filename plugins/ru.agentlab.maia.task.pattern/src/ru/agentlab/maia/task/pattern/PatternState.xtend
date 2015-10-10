package ru.agentlab.maia.task.pattern

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.task.ITask

@Accessors
class PatternState implements IPatternState {

	String name

	ITask node

	new(String name) {
		this.name = name
	}

}