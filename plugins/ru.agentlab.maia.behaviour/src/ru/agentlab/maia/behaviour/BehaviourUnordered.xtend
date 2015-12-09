package ru.agentlab.maia.behaviour

import java.util.HashSet
import org.eclipse.xtend.lib.annotations.Accessors

abstract class BehaviourUnordered extends BehaviourScheduler {

	@Accessors
	val protected childs = new HashSet<IBehaviour>

	var protected IBehaviour current = null

	override addChild(IBehaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		val added = childs += child
		child.parent = this
//		if (added && ready) {
//			state = BehaviourState.READY
//		}
		return added
	}

	override removeChild(IBehaviour child) {
		if (child == null) {
			throw new NullPointerException("Node can't be null")
		}
		val removed = childs -= child
		if (removed && childs.empty) {
			state = BehaviourState.UNKNOWN
		}
		return removed
	}

	override clear() {
		childs.clear
		current = null
		state = BehaviourState.UNKNOWN
	}
	
	override protected getCurrent() {
		return current
	}

//	def boolean isFirst(IBehaviour subtask)

//	def boolean isReady()

}
