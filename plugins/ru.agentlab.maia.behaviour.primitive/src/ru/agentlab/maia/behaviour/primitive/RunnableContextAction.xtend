package ru.agentlab.maia.behaviour.primitive

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.BehaviourPrimitive
import ru.agentlab.maia.behaviour.IBehaviourScheduler

class RunnableContextAction extends BehaviourPrimitive {

	@Accessors
	var IBehaviourScheduler parentNode

	override doInject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doUninject() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override doRun() {
//		val task = context.getService(KEY_TASK)
//		if (task instanceof Runnable) {
//			task.run
//		}
		return null
	}

	override reset() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}