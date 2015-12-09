package ru.agentlab.maia.behaviour

import java.util.concurrent.atomic.AtomicReference
import ru.agentlab.maia.behaviour.execution.NativeException

abstract class BehaviourPrimitive extends Behaviour {

	var protected implementation = new AtomicReference<Object>

	override execute() {
		try {
			doInject()
			doRun()
			doUninject()
			
			setSuccessState()
		} catch (Exception e) {
			setFailedState(new NativeException(e))
		}
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}
