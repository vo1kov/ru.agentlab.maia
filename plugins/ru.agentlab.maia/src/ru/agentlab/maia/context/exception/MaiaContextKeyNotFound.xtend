package ru.agentlab.maia.context.exception

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
	
	new(Throwable cause) {
		super(cause)
	}
	
}