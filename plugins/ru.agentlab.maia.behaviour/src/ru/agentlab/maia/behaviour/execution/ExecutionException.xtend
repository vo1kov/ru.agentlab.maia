package ru.agentlab.maia.behaviour.execution

import org.eclipse.xtend.lib.annotations.Accessors

class ExecutionException {

	@Accessors
	val ExecutionException cause
	
	@Accessors
	String name

	new() {
		this.cause = null
	}

	new(ExecutionException cause) {
		this.cause = cause
	}

}
