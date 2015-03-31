package ru.agentlab.maia.internal.behaviour

import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.annotations.Optional
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionDone
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.context.IContributionService

class Behaviour implements IBehaviour {

//	val static LOGGER = LoggerFactory.getLogger(Behaviour)
	@Inject
	@Accessors
	IEclipseContext context
	
	@Inject
	IScheduler scheduler

	protected volatile boolean startFlag = true

	override getState() {
//		context.runAndTrack(new RunAndTrack(){
//			
//			override changed(IEclipseContext context) {
//				throw new UnsupportedOperationException("TODO: auto-generated method stub")
//			}
//			
//			})
		return context.get(KEY_STATE) as String
	}

	override action() {
		if (contributor != null) {
			if (startFlag) {
				onStart
				startFlag = false
			}
			ContextInjectionFactory.invoke(contributor, Action, context)
		} else {
//			LOGGER.warn("Contributor is null")
			return null
		}
	}
	
	@Inject @Optional
	def void onContributorChange(@Named(IContributionService.KEY_CONTRIBUTOR) Object contributor){
		startFlag = true
		scheduler.restart(this)
	}
	
//	@Inject @Optional
//	def void onSchedulerChange(IScheduler scheduler){
//		this.scheduler.remove(this)
//		scheduler.add(context)
//		this.scheduler = scheduler
//	}

	override boolean isDone() {
		ContextInjectionFactory.invoke(contributor, ActionDone, context) as Boolean
	}

	def void stop() {
	}

	override void onStart() {
	}

	def Object getContributor() {
		context.get(IContributionService.KEY_CONTRIBUTOR)
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