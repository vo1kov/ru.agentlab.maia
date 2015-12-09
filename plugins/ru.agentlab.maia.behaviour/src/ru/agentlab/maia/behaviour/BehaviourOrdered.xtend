package ru.agentlab.maia.behaviour

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * Task scheduler which selects tasks in order of adding.
 */
abstract class BehaviourOrdered extends BehaviourScheduler {

	@Accessors
	val protected childs = new ArrayList<IBehaviour>

	var protected int index = 0

	override final addChild(IBehaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (childs.contains(child)) {
			return false
		}
		childs += child
		child.parent = this
		if (childs.size == 1) {
			state = BehaviourState.READY
		}
		return true
	}

	override final removeChild(IBehaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(child)
		if (i != -1) {
			childs.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i === index && index === childs.size()) {
				index = 0
			}
			if (childs.empty) {
				state = BehaviourState.UNKNOWN
			}
			return true
		} else {
			return false
		}
	}
	
	override notifyChildSuccess() {
		if (finished) {
			setSuccessState
		} else {
			schedule()
			setWorkingState
		}
	}

	override clear() {
		childs.clear
		index = 0
		state = BehaviourState.UNKNOWN
	}

	override protected getCurrent() {
		childs.get(index)
	}

	def protected finished() {
		return index == childs.size - 1
	}

	def protected schedule() {
		index = (index + 1) % childs.size
	}

}
