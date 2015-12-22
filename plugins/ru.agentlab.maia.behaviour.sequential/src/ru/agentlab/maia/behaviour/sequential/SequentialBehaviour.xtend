package ru.agentlab.maia.behaviour.sequential

import java.util.ArrayList
import ru.agentlab.maia.behaviour.Behaviour
import ru.agentlab.maia.behaviour.IBehaviourScheduler

import static ru.agentlab.maia.behaviour.BehaviourState.*

/**
 * Sequential implementation of {@link IBehaviourScheduler}.
 * Select child nodes in order of adding.
 * 
 * @author Dmitry Shishkin
 */
class SequentialBehaviour extends Behaviour implements IBehaviourScheduler {

	val protected childs = new ArrayList<Behaviour>

	var protected int index = 0

	override getChilds() {
		return childs
	}

	override addChild(Behaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (!childs.contains(child)) {
			childs.add(child)
			if (state === UNKNOWN) {
				state = READY
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
	override removeChild(Behaviour child) {
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
				state = UNKNOWN
			}
			return true
		} else {
			return false
		}
	}

	override clear() {
		childs.clear
		index = 0
		state = UNKNOWN
	}

	override execute() throws Exception {
		val current = childs.get(index)
		try {
			current.execute
			switch (current.state) {
				case SUCCESS: {
					if (index === childs.size - 1) {
						state = SUCCESS
					} else {
						index = index + 1
						state = WORKING
					}
				}
				default: {
					state = current.state
				}
			}
		} catch (Exception e) {
			state = FAILED
			throw e
		}
	}

}
