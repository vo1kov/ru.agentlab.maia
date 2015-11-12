package ru.agentlab.maia.behaviour

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * <p>Abstract {@link ITaskScheduler} implementation.</p>
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
abstract class BehaviourScheduler extends Behaviour implements IBehaviourScheduler {

	/**
	 * <p>The number of current retries to perform an action.</p>
	 */
	var protected long retries = 0L

	/**
	 * <p>The maximum number of retries to perform an action.</p>
	 */
	var protected long retriesLimit = RETRIES_ONE_TIME
	
	override final addChild(IBehaviour node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val added = internalAddChild(node)
		if (added) {
			node.parent = this
			if (childs.size == 1) {
				state = BehaviourState.READY
			}
		}
		return added
	}

	override reset() {
		retries = 0
		if (childs.size > 0) {
			state = BehaviourState.READY
		}
		childs.forEach[reset]
	}

	override restart() {
		retries++
	}

	override final removeChild(IBehaviour node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		val removed = internalRemoveChild(node)
		if (removed && childs.empty) {
			state = BehaviourState.UNKNOWN
		}
		return removed
	}

	override clear() {
		internalClear()
		state = BehaviourState.UNKNOWN
	}

	def protected final void schedule() {
		internalSchedule()
		state = BehaviourState.WORKING
	}

	def protected final void idle() {
		state = BehaviourState.WORKING
	}

	def protected void internalSchedule()

	def protected boolean internalAddChild(IBehaviour task)

	def protected boolean internalRemoveChild(IBehaviour task)

	def protected void internalClear()

}