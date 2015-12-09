package ru.agentlab.maia.behaviour.execution

import org.eclipse.xtend.lib.annotations.Accessors

class NativeException extends ExecutionException {

	@Accessors
	val Throwable nativeCause
	
	new(Throwable cause) {
		super(null)
		this.nativeCause = cause
	}

}
