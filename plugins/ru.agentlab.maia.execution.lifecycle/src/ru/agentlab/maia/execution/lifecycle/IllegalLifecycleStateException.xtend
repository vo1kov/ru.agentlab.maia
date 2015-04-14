package ru.agentlab.maia.execution.lifecycle

class IllegalLifecycleStateException extends IllegalStateException {
	
	new(String arg0) {
		super(arg0)
	}
	
	new(String arg0, Throwable arg1) {
		super(arg0, arg1)
	}
	
}