package ru.agentlab.maia.behaviour.fsm

import java.util.ArrayList
import java.util.HashMap
import java.util.List
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.behaviour.BehaviourUnordered
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourException
import ru.agentlab.maia.behaviour.IExecutionStep
import ru.agentlab.maia.event.IMaiaEventBroker

class FsmBehaviour extends BehaviourUnordered implements IFsmBehaviour {

	var IMaiaEventBroker broker

//	var IBehaviour firstChild
	val List<EventFsmTransition> eventTransitions = new ArrayList

	val Map<IExecutionStep, IExecutionStep> transitions = new HashMap

	@Inject
	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override addTransition(IExecutionStep from, IExecutionStep to) {
		if (from == null || from == this) {
			if (to instanceof IBehaviour) {
				current = to
			} else {
				throw new IllegalArgumentException('''Initial transition can't have an exception target''')
			}
		}
		if (to == null || to == this) {
			if (to instanceof IBehaviourException) {
				
			}
		}
		transitions.put(from, to)
	}

	override addEventTransition(IBehaviour from, IBehaviour to, String topic) {
		if (from == null) {
			throw new IllegalArgumentException('''Acynchronous transition can't be initial''')
		}
		val existing = eventTransitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			val transition = new EventFsmTransition(from, to, topic)
			eventTransitions += transition
			return transition
		} else {
			return null
		}
	}

	override execute() {
		val eventTransitions = eventTransitions.filter[it.from == current]
		eventTransitions.forEach [
			broker.subscribe(it.topic, [event | ])
		]
		super.execute()
	}

	override notifyChildFailed(IBehaviourException exception) {
		val next = transitions.get(exception)
		switch (next) {
			IBehaviourException: {
				setFailedState(next)
			}
			IBehaviour: {
				current = next
				setWorkingState()
			}
			default: {
				setFailedState(null)
			}
		}
	}

	override notifyChildSuccess() {
		if (!transitions.containsKey(current)) {
			throw new IllegalStateException('''Behaviour [«this»] have no default transition from state [«current»]''')
		}
		val next = transitions.get(current)
		switch (next) {
			IBehaviourException: {
				setFailedState(next)
			}
			IBehaviour: {
				current = next
				setWorkingState()
			}
			default: {
				// null indicate that it is final state
				setSuccessState()
			}
		}
	}

}
