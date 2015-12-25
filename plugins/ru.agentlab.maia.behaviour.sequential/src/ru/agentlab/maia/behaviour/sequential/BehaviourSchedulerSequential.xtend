package ru.agentlab.maia.behaviour.sequential

import java.util.ArrayList
import ru.agentlab.maia.behaviour.BehaviourScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

/**
 * Sequential implementation of {@link IBehaviourScheduler}.
 * Select child nodes in order of adding.
 * 
 * @author Dmitry Shishkin
 */
class BehaviourSchedulerSequential extends BehaviourScheduler implements IBehaviourSchedulerSequential {

	val protected childs = new ArrayList<IBehaviour>

	var protected int index = 0

	override getChilds() {
		return childs
	}

	override addChild(IBehaviour child) {
		if (child === null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!childs.contains(child)) {
			childs.add(child)
			if (state === State.UNKNOWN) {
				state = State.READY
			}
			return true
		} else {
			return false
		}
	}

	/**
	 * Prevent current index moving.
	 * If specified index less then current index then current index should be decreased.
	 * If specified index indicates on last child then index should be reseted.
	 */
	override removeChild(IBehaviour child) {
		if (child === null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(child)
		if (i !== -1) {
			childs.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i === index && index === childs.size()) {
				index = 0
			}
			if (childs.empty) {
				state = State.UNKNOWN
			}
			return true
		} else {
			return false
		}
	}

	override clear() {
		childs.clear
		index = 0
		state = State.UNKNOWN
	}

	override protected getCurrent() {
		return childs.get(index)
	}

	override protected handleChildSuccess() {
		if (index === childs.size - 1) {
			state = State.SUCCESS
		} else {
			index = index + 1
			state = State.WORKING
		}
	}

}
