package ru.agentlab.maia.memory.injector

class InjectionException extends Exception {
	
	new() {
		
	}
	
	new(String arg0) {
		super(arg0)
	}
	
	new(String arg0, Throwable arg1) {
		super(arg0, arg1)
	}
	
	new(Throwable arg0) {
		super(arg0)
	}
	
}