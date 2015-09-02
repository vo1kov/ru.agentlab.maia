package ru.agentlab.maia.execution.scheduler.pattern.state

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.tree.IExecutionNode

@Accessors
class PatternState {

	String name

	IExecutionNode node

	new(String name) {
		this.name = name
	}

}