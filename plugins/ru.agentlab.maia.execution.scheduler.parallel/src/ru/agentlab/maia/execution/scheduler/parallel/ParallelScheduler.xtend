package ru.agentlab.maia.execution.scheduler.parallel

import java.util.ArrayList
import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.ExceptionHandling
import ru.agentlab.maia.execution.IExecutionNode

class ParallelScheduler extends AbstractExecutionScheduler {

	val protected blockedChilds = new ArrayList<IExecutionNode>

	val protected finishedChilds = new ArrayList<IExecutionNode>

	val protected exceptionChilds = new ArrayList<IExecutionNode>

	var byte failHandling = ExceptionHandling.SKIP
	var byte successHandling = ExceptionHandling.SKIP
	var byte blockHandling = ExceptionHandling.SKIP
	var byte readyHandling = ExceptionHandling.SKIP

	var byte finishHandling = ExceptionHandling.SUCCESS

	override notifyChildReady(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		if (childs.contains(node)) {
			// Already ready state
			return
		}
		var removed = blockedChilds.remove(node)
		if (!removed) {
			removed = finishedChilds.remove(node)
		}
		if (!removed) {
			removed = exceptionChilds.remove(node)
		}
		if (!removed) {
			throw new IllegalArgumentException("Node doesn't contains in the scheduler")
		}
		childs += node
		state = READY
		parent.get?.notifyChildReady(this)
	}

	/**
	 * <p>
	 * If some child node become a {@link IExecutionNode#BLOCKED BLOCKED} state 
	 * then scheduler can:
	 * </p><ol>
	 * <li>Stay in {@link IExecutionNode#READY READY} state and continue 
	 * scheduling if there is some ready child nodes.</li>
	 * <li>Become a {@link IExecutionNode#BLOCKED BLOCKED} state if there is no ready
	 * child nodes.</li>
	 * <li>Never be a {@link IExecutionNode#SUCCESS SUCCESS} state after child are 
	 * blocked.</li>
	 * <li>Never be a {@link IExecutionNode#EXCEPTION EXCEPTION} state after child are 
	 * blocked.</li>
	 * </ol>
	 */
	override notifyChildBlocked() {
		blockedChilds += childs.remove(index)
		if (!childs.empty) {
			schedule()
		} else {
			finish()
		}
	}

	/**
	 * <p>
	 * If some child node become a {@link IExecutionNode#SUCCESS SUCCESS} state 
	 * then scheduler can:
	 * </p><ol>
	 * <li>Stay in {@link IExecutionNode#READY READY} state and continue 
	 * scheduling if there is some ready child nodes.</li>
	 * <li>Become a {@link IExecutionNode#BLOCKED BLOCKED} state if there is no ready
	 * child nodes but some nodes are blocked.</li>
	 * <li>Become a {@link IExecutionNode#SUCCESS SUCCESS} state if there 
	 * is no ready and blocked child nodes, i.e. all nodes are finished successfully or
	 * with some exception.</li>
	 * <li>Become a {@link IExecutionNode#EXCEPTION EXCEPTION} state if there 
	 * is no ready and blocked child nodes, but some nodes finished with exception.</li>
	 * </ol>
	 */
	override notifyChildSuccess() {
		finishedChilds += childs.remove(index)
		if (!childs.empty) {
			schedule()
		} else {
			finish()
		}
	}

	/**
	 * <p>
	 * If some child node become a {@link IExecutionNode#EXCEPTIONAL EXCEPTIONAL} state 
	 * then scheduler can:
	 * </p><ol>
	 * <li>Stay in {@link IExecutionNode#READY READY} state and continue 
	 * scheduling if there is some ready child nodes.</li>
	 * <li>Become a {@link IExecutionNode#BLOCKED BLOCKED} state if there is no ready
	 * child nodes but some nodes are blocked.</li>
	 * <li>Become a {@link IExecutionNode#EXCEPTION EXCEPTION} state if there 
	 * is no ready and blocked child nodes, i.e. all nodes are finished successfully or
	 * with some exception.</li>
	 * <li>Never be a {@link IExecutionNode#SUCCESS SUCCESS} state after child are 
	 * finished with some exception.</li>
	 * </ol>
	 */
	override notifyChildException() {
		exceptionChilds += childs.remove(index)
		if (!childs.empty) {
			schedule()
		} else {
			finish()
		}
	}

	/**
	 * Protect index overflow. Should be invoked after remove from child list.
	 */
	def protected void schedule() {
		index = index % childs.size
	}

	def protected void finish() {
		if (!blockedChilds.empty) {
			state = BLOCKED
			parent.get.notifyChildBlocked
			return
		}
		if (!exceptionChilds.empty) {
			state = EXCEPTION
			parent.get.notifyChildException
			return
		}
		state = SUCCESS
		parent.get.notifyChildSuccess
	}

}