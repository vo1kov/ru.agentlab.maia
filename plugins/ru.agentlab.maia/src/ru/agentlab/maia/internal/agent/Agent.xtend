package ru.agentlab.maia.internal.agent

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.AccessorType
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviourFactory
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageQueue
import ru.agentlab.maia.messaging.IMessageTemplate

import static extension org.eclipse.xtend.lib.annotations.AccessorType.*

class Agent implements IAgent {

	@Inject
	@Accessors(#[AccessorType.PUBLIC_GETTER, AccessorType.PACKAGE_SETTER])
	IEclipseContext context

	@Inject
	IScheduler scheduler

	@Inject
	IMessageQueue queue

	@Inject
	IBehaviourFactory behaviourFactory

	override void pause() {
		scheduler.behaviours.forEach [
			scheduler.block(it);
		]
	}

	override void stop() {
		scheduler.behaviours.forEach [
			scheduler.block(it);
		]
		context.set(IAgent.KEY_STATE, IAgent.STATE_IDLE)
	}

	override void addBehaviour(String id, Class<?> contributorClass) {
		behaviourFactory.create(this, id, contributorClass)
	}

	override receive(IMessageTemplate template) {
		queue.receive(template)
	}

	override send(IMessage message) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getState() {
		return context.get(KEY_STATE) as String
	}

}
