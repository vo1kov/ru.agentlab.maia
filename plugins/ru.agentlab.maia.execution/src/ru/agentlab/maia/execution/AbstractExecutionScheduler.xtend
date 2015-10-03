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
@Accessors
abstract class AbstractExecutionScheduler extends AbstractExecutionNode implements IExecutionScheduler {

	@Accessors(PUBLIC_GETTER)
	var protected int index = 0
	val protected childs = new ArrayList<IExecutionNode>
	val protected blockedChilds = new ArrayList<IExecutionNode>

	/**
	 * <p>The number of current retries to perform an action.</p>
	 */
	@Accessors(PUBLIC_GETTER)
	var protected long numRetries = 0L

	/**
	 * <p>The maximum number of retries to perform an action.</p>
	 */
	var protected long numRetriesMax = RETRIES_ONE_TIME

	var protected Policy policyOnChildFailed = Policy.FAILED
	var protected Policy policyOnChildSuccess = Policy.SKIP
	var protected Policy policyOnChildBlocked = Policy.BLOCKED
	var protected Policy policyOnChildWorking = Policy.IDLE
	var protected Policy policyOnAllChildsBlocked = Policy.SUCCESS
	var protected Policy policyOnAllChildsSuccess = Policy.SUCCESS

	override addChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		node.parent = this
		childs += node
	}

	override reset() {
		blockedChilds.clear
		numRetries = 0
		for (child : childs.filter(IExecutionScheduler)) {
			child.reset
		}
	}

	override restart() {
		numRetries++
		index = 0
	}

	override removeAll() {
		childs.clear
		blockedChilds.clear
		index = 0
	}

	override removeChild(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(node)
		if (i != -1) {
			childs.remove(i)
			blockedChilds.remove(node)
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

	override protected runInternal() {
		val next = if (!childs.empty) {
				childs.get(index)
			} else {
				throw new IllegalStateException("Scheduler have no ready child nodes")
			}
		next.run
	}

	override notifyChildBlocked() {
		policyOnChildBlocked.handlePolicy
	}

	override notifyChildFailed() {
		policyOnChildFailed.handlePolicy
	}

	override notifyChildSuccess() {
		policyOnChildSuccess.handlePolicy
	}

	override notifyChildWorking() {
		policyOnChildWorking.handlePolicy
	}

	override notifyChildReady(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val i = childs.indexOf(node)
		if (i == -1) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		blockedChilds.remove(node)
		state = IExecutionNode.State.READY
		parent.get?.notifyChildReady(this)
	}

	def protected void handlePolicy(Policy policy) {
		switch (policy) {
			case BLOCKED: {
				state = State.BLOCKED
				parent.get?.notifyChildBlocked
			}
			case FAILED: {
				state = State.FAILED
				parent.get?.notifyChildFailed
			}
			case SUCCESS: {
				state = State.SUCCESS
				parent.get?.notifyChildSuccess
			}
			case SCHEDULING: {
				schedule()
			}
			case RESTART: {
				restart()
				parent.get?.notifyChildWorking
			}
			case SKIP: {
				blockedChilds.add(childs.get(index))
				schedule()
			}
			case IDLE: {
				parent.get?.notifyChildWorking
			}
			case DELETED: {
				val p = parent.get
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
			if (blockedChilds.empty) {
				policyOnAllChildsBlocked.handlePolicy
			} else {
				policyOnAllChildsSuccess.handlePolicy
			}
		} else {
			parent.get?.notifyChildWorking
		}
	}

	def int getNextIndex()

}