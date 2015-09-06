package ru.agentlab.maia.execution.tree

class IllegalSchedulerStateException extends IllegalStateException {
	
	new() {
		
	}
	
	new(String s) {
		super(s)
	}
	
	new(String message, Throwable cause) {
		super(message, cause)
	}
	
	new(Throwable cause) {
		super(cause)
	}
	
}