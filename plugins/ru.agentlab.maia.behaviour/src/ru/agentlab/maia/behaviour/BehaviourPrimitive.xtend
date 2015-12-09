package ru.agentlab.maia.behaviour

import java.util.concurrent.atomic.AtomicReference

abstract class BehaviourPrimitive extends Behaviour {

	var protected implementation = new AtomicReference<Object>

	override execute() {
		try {
			doInject()
			doRun()
			doUninject()

			setSuccessState()
		} catch (Exception e) {
			exceptions.findFirst[name == e.class.name]
			setFailedState(exceptions.findFirst[name == e.class.name])
		}
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}
