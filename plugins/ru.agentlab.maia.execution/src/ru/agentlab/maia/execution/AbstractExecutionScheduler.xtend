package ru.agentlab.maia.execution

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	var protected int index = 0

	val protected childs = new ArrayList<IExecutionNode>

	val protected skipping = new ArrayList<IExecutionNode>

	var protected long retries = 0

	@Accessors
	var protected long maxRetries = RETRIES_ONE_TIME

	@Accessors
	var protected Policy childFailedPolicy = Policy.FAILED

	@Accessors
	var protected Policy childSuccessPolicy = Policy.SKIP

	@Accessors
	var protected Policy childBlockedPolicy = Policy.BLOCKED

	@Accessors
	var protected Policy schedulerFinishedPolicy = Policy.RESTART

	override addChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		node.parent = this
		childs += node
		skipping += null
	}

	override reset() {
		skipping.clear
		retries = 0
		for (child : childs.filter(IExecutionScheduler)) {
			child.reset
		}
	}

	override getChilds() {
		return childs
	}

	override restart() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	/** 
	 * Removes all nodes from the queue.
	 */
	override removeAll() {
		childs.clear
		skipping.clear
		index = 0
	}

	/** 
	 * Removes specified node from the queue.
	 * 
	 * @param node - node to be deleted
	 * 
	 * @return node previously at the scheduler 
	 */
	override removeChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(node)
		if (i != -1) {
			childs.remove(i)
			skipping.remove(i)
			if (i < index) {
				index = index - 1
			} else if (i == index && index == childs.size()) {
				index = 0
			}
			return true
		} else {
			return false
		}
	}

	override run() {
		state = State.WORKING
		val next = if (!childs.empty) {
				childs.get(index)
			} else {
				throw new IllegalStateException("Scheduler have no ready child nodes")
			}
		next.run
	}

	override notifyChildBlocked() {
		childBlockedPolicy.handlePolicy
	}

	override notifyChildFailed() {
		childFailedPolicy.handlePolicy
	}

	override notifyChildSuccess() {
		childSuccessPolicy.handlePolicy
	}

	override notifyChildReady(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(node)
		if (i == -1) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		skipping.set(i, null)
		state = IExecutionNode.State.READY
		parent.get?.notifyChildReady(this)
	}

	def protected handlePolicy(Policy policy) {
		switch (policy) {
			case Policy.BLOCKED: {
				state = State.BLOCKED
				parent.get?.notifyChildBlocked
			}
			case Policy.FAILED: {
				state = State.FAILED
				parent.get?.notifyChildFailed
			}
			case Policy.SUCCESS: {
				state = State.SUCCESS
				parent.get?.notifyChildSuccess
			}
			case Policy.WORKING: {
				schedule()
			}
			case Policy.RESTART: {
				reset()
				retries++
			}
			case Policy.SKIP: {
				val current = childs.get(index)
				skipping.set(index, current)
				schedule()
			}
		}
	}

	def protected void schedule() {
		index = nextIndex
		if (index > childs.size - 1) {
			schedulerFinishedPolicy.handlePolicy
		}
	}

	def int getNextIndex()

}