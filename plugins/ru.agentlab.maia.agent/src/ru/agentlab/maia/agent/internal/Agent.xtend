package ru.agentlab.maia.agent.internal

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.IAgent
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.IMessage
import ru.agentlab.maia.IMessageTemplate
import ru.agentlab.maia.messageq.IMessageQueue
import ru.agentlab.maia.scheduler.IScheduler

class Agent implements IAgent {

	@Inject 
	@Accessors
	IEclipseContext context

	@Inject
	IScheduler scheduler

	@Inject
	IMessageQueue quiue
	
	@PostConstruct
	def void init() {
	}

	override void pause() {
		scheduler.block(null)
	}

	override void stop() {
		scheduler.behaviours.forEach [
			scheduler.block(it);
		]
	}

	override void addBehaviour(IBehaviour behaviour) {
		val id = "" // TODO
		val behaviourContext = context.createChild("Behaviour [" + id + "] Context") => [
			set(IBehaviour.KEY_NAME, id)
			set(IBehaviour.KEY_STATE, IBehaviour.STATE_READY)
		]
	}

	override receive(IMessageTemplate template) {
		quiue.receive(template)
	}

	override send(IMessage message) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override getState() {
		return context.get(KEY_STATE) as String
	}
	
	override getName(){
		return context.get(KEY_NAME) as String
	}

}
