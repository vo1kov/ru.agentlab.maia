package ru.agentlab.maia.behaviour

class BehaviourExecutionException extends Exception {

	new() {
		super()
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

	protected new(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace)
	}

}