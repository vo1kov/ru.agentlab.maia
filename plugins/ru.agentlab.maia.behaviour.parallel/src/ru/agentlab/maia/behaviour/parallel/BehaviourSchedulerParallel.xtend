package ru.agentlab.maia.behaviour.parallel

import java.util.ArrayList
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.behaviour.BehaviourScheduler

/**
 * <p>Parallel implementation of {@link ITaskScheduler}.
 * Execute until all nodes are performed.  
 * Select child nodes in order of adding.</p>
 * 
 * <p>Default policies:</p>
 * 
 * <ul>
 * <li>When any child become {@link TaskState#BLOCKED BLOCKED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link TaskState#FAILED FAILED} then 
 * scheduler skip it and select next;</li>
 * <li>When any child become {@link TaskState#SUCCESS SUCCESS} then 
 * scheduler scheduling to next child;</li>
 * <li>When all child nodes are executed successfully then 
 * scheduler become {@link TaskState#SUCCESS SUCCESS};</li>
 * </ul>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
class BehaviourSchedulerParallel extends BehaviourScheduler implements IBehaviourSchedulerParallel {

	val protected childs = new ArrayList<IBehaviour>

	val protected blockedSubtasks = new ArrayList<IBehaviour>

	val protected terminatedSubtasks = new ArrayList<IBehaviour>

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
			if (state == State.UNKNOWN) {
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
		val i = childs.indexOf(child)
		if (i != -1) {
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
		terminatedSubtasks += childs.remove(index)
		if (childs.empty) {
			state = State.SUCCESS
		} else {
			state = State.WORKING
		}
	}

	override protected handleChildBlocked() {
		blockedSubtasks += childs.remove(index)
		if (childs.empty) {
			state = State.BLOCKED
		} else {
			state = State.WORKING
		}
	}

	override protected handleChildWorking() {
		index = (index + 1) % childs.size
		state = State.WORKING
	}

}
