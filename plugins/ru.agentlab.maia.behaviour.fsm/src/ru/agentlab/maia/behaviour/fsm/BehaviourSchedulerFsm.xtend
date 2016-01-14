package ru.agentlab.maia.behaviour.fsm

import java.util.Collection
import java.util.HashMap
import java.util.Map
import javax.inject.Inject
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourScheduler
import ru.agentlab.maia.event.IMaiaEventBroker

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourSchedulerFsm extends BehaviourScheduler implements IBehaviourSchedulerFsm {

	var IMaiaEventBroker broker

	val Map<IBehaviour, Object> behaviourTransitions = new HashMap

	val Map<IBehaviour.Exception<?>, Object> exceptionTransitions = new HashMap

	val Map<IBehaviour, Collection<Object>> eventTransitions = new HashMap

	var IBehaviour current = null

	@Inject
	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override getChilds() {
		return behaviourTransitions.keySet
	}

	override addChild(IBehaviour child) {
		if (child === null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!behaviourTransitions.containsKey(child)) {
			behaviourTransitions.put(child, null)
			if (state === State.UNKNOWN) {
				state = State.READY
			}
			return true
		} else {
			return false
		}
	}

	override removeChild(IBehaviour child) {
		if (child === null) {
			throw new NullPointerException("Node can't be null")
		}
		if (behaviourTransitions.containsKey(child)) {
			behaviourTransitions.remove(child)
			if (behaviourTransitions.empty) {
				state = State.UNKNOWN
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
		state = State.UNKNOWN
	}

	override addBehaviourTransition(Behaviour from, Behaviour to) {
		from.checkFrom
		to.checkTo
		behaviourTransitions.put(from, to)
	}

	override addBehaviourTransition(Behaviour from, IBehaviour.Exception<?> to) {
		from.checkFrom
		to.checkTo
		behaviourTransitions.put(from, to)
	}

	override addExceptionTransition(IBehaviour.Exception<?> from, Behaviour to) {
		from.checkFrom
		to.checkTo
		exceptionTransitions.put(from, to)
	}

	override addExceptionTransition(IBehaviour.Exception<?> from, IBehaviour.Exception<?> to) {
		from.checkFrom
		to.checkTo
		exceptionTransitions.put(from, to)
	}

	override addEventTransition(Behaviour from, Behaviour to, String topic) {
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

	override addEventTransition(Behaviour from, IBehaviour.Exception<?> to, String topic) {
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

	override protected getCurrent() {
		if (current === null) {
			current = behaviourTransitions.get(null) as Behaviour
		}
		return current
	}

	override protected handleChildSuccess() {
		val next = behaviourTransitions.get(current)
		next.changeState
	}

	override protected handleChildFailed(java.lang.Exception e) throws java.lang.Exception {
		val exception = current.exceptions.findFirst[type.isAssignableFrom(e.class)]
		if (exception != null) {
			val next = exceptionTransitions.get(exception)
			next.changeState
		} else {
			super.handleChildFailed(e)
		}

	}

	def private void checkFrom(Behaviour from) {
		if (from != null && !childs.exists[it === from]) {
			throw new IllegalArgumentException('''BehaviourException [«from»] is not a child of scheduler''')
		}
	}

	def private void checkTo(Behaviour to) {
		if (!childs.exists[it === to]) {
			throw new IllegalArgumentException('''BehaviourException [«to»] is not a child of scheduler''')
		}
	}

	def private void checkFrom(IBehaviour.Exception<?> from) {
		if (!childs.exists[it.exceptions.exists[it === from]]) {
			throw new IllegalArgumentException('''BehaviourException [«from»] is not a child of scheduler''')
		}
	}

	def private void checkTo(IBehaviour.Exception<?> to) {
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
				state = State.WORKING
			}
			IBehaviour.Exception<?>: {
				current = null
				state = State.FAILED
				throw ( next.type.newInstance as java.lang.Exception)
			}
			default: {
				current = null
				state = State.SUCCESS
			}
		}
	}

}
