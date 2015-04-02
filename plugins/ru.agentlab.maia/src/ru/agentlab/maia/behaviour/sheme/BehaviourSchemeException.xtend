package ru.agentlab.maia.behaviour.sheme

import java.lang.Exception

class BehaviourSchemeException extends Exception {
	
	new(String message) {
		super(message)
	}
	
	new(String message, Throwable cause) {
		super(message, cause)
	}
	
}