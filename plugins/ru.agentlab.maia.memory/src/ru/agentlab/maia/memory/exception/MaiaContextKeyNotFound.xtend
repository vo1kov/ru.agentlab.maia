package ru.agentlab.maia.memory.exception

import java.lang.Exception

class MaiaContextKeyNotFound extends Exception {
	
	new() {
		
	}
	
	new(String message) {
		super(message)
	}
	
	new(String message, Throwable cause) {
		super(message, cause)
	}
	
	protected new(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace)
	}
	
	new(Throwable cause) {
		super(cause)
	}
	
}