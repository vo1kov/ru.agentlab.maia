package ru.agentlab.maia.behaviour.fsm

import java.util.Collection
import java.util.HashMap
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourException
import ru.agentlab.maia.behaviour.IBehaviourScheduler
import ru.agentlab.maia.event.IMaiaEventBroker

import static ru.agentlab.maia.behaviour.BehaviourState.*

/**
 * 
 * @author Dmitry Shishkin
 */
class FsmBehaviour extends Behaviour implements IBehaviourScheduler {

	var IMaiaEventBroker broker

	val Map<Behaviour, Object> behaviourTransitions = new HashMap

	val Map<BehaviourException<?>, Object> exceptionTransitions = new HashMap

	val Map<Behaviour, Collection<Object>> eventTransitions = new HashMap

	var Behaviour current = null

	@Inject
	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override getChilds() {
		return behaviourTransitions.keySet
	}

	override addChild(Behaviour child) {
		if (!behaviourTransitions.containsKey(child)) {
			behaviourTransitions.put(child, null)
			if (state === UNKNOWN) {
				state = READY
			}
			return true
		} else {
			return false
		}
	}

	override removeChild(Behaviour child) {
		if (behaviourTransitions.containsKey(child)) {
			behaviourTransitions.remove(child)
			if (behaviourTransitions.empty) {
				state = UNKNOWN
			}
			return true
		} else {
			return false
		}
	}

	override clear() {
		behaviourTransitions.clear
		exceptionTransitions.clear
		eventTransitions.clear
		state = UNKNOWN
	}

	override execute() {
		if (current === null) {
			current = behaviourTransitions.get(null) as Behaviour
		}
		try {
			current.execute
			switch (current.state) {
				case SUCCESS: {
					val next = behaviourTransitions.get(current)
					next.changeState
				}
				default: {
					state = current.state
				}
			}
		} catch (Exception e) {
			val exception = current.exceptions.findFirst[type.isAssignableFrom(e.class)]
			if (exception != null) {
				state = WORKING
				val next = exceptionTransitions.get(exception)
				next.changeState
			} else {
				state = FAILED
				throw e
			}
		}
	}

	def addBehaviourTransition(Behaviour from, Behaviour to) {
		from.checkFrom
		to.checkTo
		behaviourTransitions.put(from, to)
	}

	def addBehaviourTransition(Behaviour from, BehaviourException<?> to) {
		from.checkFrom
		to.checkTo
		behaviourTransitions.put(from, to)
	}

	def addExceptionTransition(BehaviourException<?> from, Behaviour to) {
		from.checkFrom
		to.checkTo
		exceptionTransitions.put(from, to)
	}

	def addExceptionTransition(BehaviourException<?> from, BehaviourException<?> to) {
		from.checkFrom
		to.checkTo
		exceptionTransitions.put(from, to)
	}

	def addEventTransition(Behaviour from, Behaviour to, String topic) {
		from.checkFrom
		to.checkTo
		if (from === null) {
			throw new IllegalArgumentException('''Event transition can't be initial''')
		}
//		val existing = asyncTransitions.findFirst[it.from == from && it.to == to]
//		if (existing == null) {
//			val transition = new EventFsmTransition(from, to, topic)
//			asyncTransitions += transition
//			return transition
//		} else {
//			return null
//		}
	}

	def addEventTransition(Behaviour from, BehaviourException<?> to, String topic) {
		from.checkFrom
		to.checkTo
		if (from === null) {
			throw new IllegalArgumentException('''Event transition can't be initial''')
		}
//		val existing = asyncTransitions.findFirst[it.from == from && it.to == to]
//		if (existing == null) {
//			val transition = new EventFsmTransition(from, to, topic)
//			asyncTransitions += transition
//			return transition
//		} else {
//			return null
//		}
	}

	def private void checkFrom(Behaviour from) {
		if (!childs.exists[it === from]) {
			throw new IllegalArgumentException('''BehaviourException [«from»] is not a child of scheduler''')
		}
	}

	def private void checkTo(Behaviour to) {
		if (!childs.exists[it === to]) {
			throw new IllegalArgumentException('''BehaviourException [«to»] is not a child of scheduler''')
		}
	}

	def private void checkFrom(BehaviourException<?> from) {
		if (!childs.exists[it.exceptions.exists[it === from]]) {
			throw new IllegalArgumentException('''BehaviourException [«from»] is not a child of scheduler''')
		}
	}

	def private void checkTo(BehaviourException<?> to) {
		if (!childs.exists[it.exceptions.exists[it === to]]) {
			throw new IllegalArgumentException('''BehaviourException [«to»] is not a child of scheduler''')
		}
		if (!exceptions.exists[it === to]) {
			throw new IllegalArgumentException('''BehaviourException [«to»] is not a child of scheduler''')
		}
	}

	def private changeState(Object next) {
		switch (next) {
			Behaviour: {
				current = next
				state = WORKING
			}
			BehaviourException<?>: {
				current = null
				state = FAILED
				throw ( next.type.newInstance as Exception)
			}
			default: {
				current = null
				state = SUCCESS
			}
		}
	}

}
