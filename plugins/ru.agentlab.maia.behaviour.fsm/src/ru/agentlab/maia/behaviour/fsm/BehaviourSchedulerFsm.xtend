package ru.agentlab.maia.behaviour.fsm

import java.util.HashMap
import java.util.Map
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.BehaviourScheduler

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourSchedulerFsm extends BehaviourScheduler implements IBehaviourSchedulerFsm {

	val private static EMPTY = new Object

	val Map<Object, Object> transitions = new HashMap

	var IBehaviour current = null

	override getChilds() {
		return transitions.keySet.filter(IBehaviour)
	}

	override addChild(IBehaviour child) {
		if (child === null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!transitions.containsKey(child)) {
			transitions.put(child, EMPTY)
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
		if (transitions.containsKey(child)) {
			transitions.remove(child)
			if (transitions.empty) {
				state = State.UNKNOWN
			}
			return true
		} else {
			return false
		}
	}

	override clear() {
		transitions.clear
		state = State.UNKNOWN
	}

	override addTransition(IBehaviour from, IBehaviour to) {
		from.checkFrom
		to.checkTo
		transitions.put(from, to)
		if (state == State.UNKNOWN && !transitions.values.contains(EMPTY)) {
			state = State.READY
		}
	}

	override addTransition(IBehaviour from, IBehaviour.Exception<?> to) {
		from.checkFrom
		to.checkTo
		transitions.put(from, to)
		if (state == State.UNKNOWN && !transitions.values.contains(EMPTY)) {
			state = State.READY
		}
	}

	override addTransition(IBehaviour.Exception<?> from, Behaviour to) {
		from.checkFrom
		to.checkTo
		transitions.put(from, to)
		if (state == State.UNKNOWN && !transitions.values.contains(EMPTY)) {
			state = State.READY
		}
	}

	override addTransition(IBehaviour.Exception<?> from, IBehaviour.Exception<?> to) {
		from.checkFrom
		to.checkTo
		transitions.put(from, to)
		if (state == State.UNKNOWN && !transitions.values.contains(EMPTY)) {
			state = State.READY
		}
	}

	override void removeTransition(IBehaviour.Exception<?> from) {
		transitions.remove(from)
	}

	override void removeTransition(IBehaviour from) {
		transitions.put(from, EMPTY)
		state = State.UNKNOWN
	}

	override protected getCurrent() {
		if (current === null) {
			current = transitions.get(null) as Behaviour
		}
		return current
	}

	override protected handleChildSuccess() {
		val next = transitions.get(current)
		next.changeState
	}

	override protected handleChildFailed(java.lang.Exception e) throws java.lang.Exception {
		val exception = current.exceptions.findFirst[type.isAssignableFrom(e.class)]
		if (exception != null) {
			val next = transitions.get(exception)
			next.changeState
		} else {
			super.handleChildFailed(e)
		}

	}

	def private void checkFrom(IBehaviour from) {
		if (from != null && !childs.exists[it === from]) {
			throw new IllegalArgumentException('''BehaviourException [«from»] is not a child of scheduler''')
		}
	}

	def private void checkTo(IBehaviour to) {
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
				throw ( next.type.newInstance as java.lang.Exception)
			}
			default: {
				current = null
				state = State.SUCCESS
			}
		}
	}

}
