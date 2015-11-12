package ru.agentlab.maia.behaviour

import java.util.concurrent.atomic.AtomicReference

abstract class BehaviourPrimitive extends Behaviour {

	var protected implementation = new AtomicReference<Object>

	override protected internalExecute() {
		try {
			doInject()
			doRun()
			doUninject()

			state = BehaviourState.SUCCESS
		} catch (Exception e) {
			state = BehaviourState.FAILED
		}
	}

	def protected void doInject()

	def protected void doUninject()

	def protected Object doRun()

}