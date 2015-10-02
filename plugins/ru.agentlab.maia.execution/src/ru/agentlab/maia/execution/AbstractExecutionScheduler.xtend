package ru.agentlab.maia.execution

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

/**
 * <p>Abstract {@link IExecutionScheduler} implementation.</p>
 *
 * <p>Implementation guarantee:</p>
 * 
 * <ul>
 * <li>execution of {@code run()} method will be redirected to one of child 
 * nodes. What exactly child node should be chosen depends of concrete
 * implementation.</li>
 * <li>when child node will notify about state change then appropriate policy 
 * will be handled.</li>
 * <li>when all retries will be exhausted then appropriate policy 
 * will be handled.</li>
 * </ul>
 * 
 * <p>Concrete implementations must implement algorithm of retrieving next 
 * child node. Additionally concrete implementation can change policies for
 * satisfying behavior requirements.</p>
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
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
	var protected Policy childWorkingPolicy = Policy.IDLE

	@Accessors
	var protected Policy noChildsSkipedPolicy = Policy.SUCCESS

	@Accessors
	var protected Policy someChildsSkipedPolicy = Policy.FAILED

	override addChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		node.parent = this
		childs += node
		skipping.add(null)
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

	override notifyChildWorking() {
		childWorkingPolicy.handlePolicy
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

	def protected void handlePolicy(Policy policy) {
		val p = parent.get
		switch (policy) {
			case BLOCKED: {
				state = State.BLOCKED
				if (p != null) {
					p.notifyChildBlocked
				} else {
					// Do nothing..
				}
			}
			case FAILED: {
				state = State.FAILED
				if (p != null) {
					p.notifyChildFailed
				} else {
					// Do nothing..
				}
			}
			case SUCCESS: {
				state = State.SUCCESS
				if (p != null) {
					p.notifyChildSuccess
				} else {
					// Do nothing..
				}
			}
			case SCHEDULING: {
				schedule()
				if (p != null) {
					p.notifyChildWorking
				} else {
					// Do nothing..
				}
			}
			case RESTART: {
				reset()
				retries++
				if (p != null) {
					p.notifyChildWorking
				} else {
					// Do nothing..
				}
			}
			case SKIP: {
				val current = childs.get(index)
				skipping.set(index, current)
				schedule()
				if (p != null) {
					p.notifyChildWorking
				} else {
					// Do nothing..
				}
			}
			case IDLE: {
				if (p != null) {
					p.notifyChildWorking
				} else {
					// Do nothing..
				}
			}
			case DELETED: {
				if (p != null) {
					p.removeChild(this)
					p.notifyChildWorking
				}
			}
		}
	}

	def protected void schedule() {
		index = nextIndex
		if (index > childs.size - 1) {
			if (skipping.forall[it == null]) {
				noChildsSkipedPolicy.handlePolicy
			} else {
				someChildsSkipedPolicy.handlePolicy
			}
		}
	}

	def int getNextIndex()

}