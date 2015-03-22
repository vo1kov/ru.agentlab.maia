package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionDone
import ru.agentlab.maia.behaviour.IBehaviour

class Behaviour implements IBehaviour {

	@Inject
	@Accessors
	IEclipseContext context

	protected boolean startFlag = true

	override getState() {
		return context.get(KEY_STATE) as String
	}

	override Object action() {
		if (startFlag) {
			onStart
			startFlag = false
		}
		ContextInjectionFactory.invoke(contributor, Action, context)
	}

	override boolean isDone() {
		ContextInjectionFactory.invoke(contributor, ActionDone, context) as Boolean
	}

	def void stop() {
	}

	override void onStart() {
	}

	def Object getContributor() {
		context.get(KEY_CONTRIBUTOR)
	}

	override onEnd() {
		return 0
	}

	override reset() {
	}

	def public final void actionWrapper() {
		if (startFlag) {
			onStart
			startFlag = false
		}

		// Maybe the behaviour was removed from another thread
//		if (myAgent != null) {
//			myAgent.notifyChangeBehaviourState(this, Behaviour.STATE_READY, Behaviour.STATE_RUNNING)
//		}
		action()
//		if (myAgent != null) {
//			myAgent.notifyChangeBehaviourState(this, Behaviour.STATE_RUNNING, Behaviour.STATE_READY)
//		}
	}

}