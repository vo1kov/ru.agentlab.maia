package ru.agentlab.maia.behaviour.fsm

import java.util.ArrayList
import java.util.Collection
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

	val Map<IExecutionStep, Collection<IExecutionStep>> asyncTransitions = new HashMap

	@Inject
	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override addTransition(IExecutionStep from, IExecutionStep to) {
		if (isInitial(from, to)) {
			if (to instanceof IBehaviour) {
				if (!childs.contains(to)) {
					throw new IllegalArgumentException('''Behaviour [«to»] is not a child of scheduler''')
				}
				current = to
			} else {
				throw new IllegalArgumentException('''Initial transition can't have an exception target''')
			}
		}
		if (isFinal(from, to)) {
			if (to instanceof IBehaviourException) {
			}
		}
		transitions.put(from, to)
	}

	def private isInitial(IExecutionStep from, IExecutionStep to) {
		return from == null || from == this
	}

	def private isFinal(IExecutionStep from, IExecutionStep to) {
		return to == null || to == this
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
		if (transitions.containsKey(current)) {
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
		} else if (asyncTransitions.containsKey(current)) {
			setBlockedState()
		} else {
			throw new IllegalStateException('''Behaviour [«this»] have no any transition from state [«current»]''')
		}

	}

}
