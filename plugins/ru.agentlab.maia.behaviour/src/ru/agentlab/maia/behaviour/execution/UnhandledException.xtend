package ru.agentlab.maia.behaviour.execution

class UnhandledException extends ExecutionException {

	new(ExecutionException cause) {
		super(cause)
	}

	new() {
	}
}
