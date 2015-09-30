package ru.agentlab.maia.execution.scheduler.parallel

import java.util.ArrayList
import ru.agentlab.maia.execution.AbstractExecutionScheduler
import ru.agentlab.maia.execution.IExecutionNode

class ParallelScheduler extends AbstractExecutionScheduler {

	val blockedChilds = new ArrayList<IExecutionNode>

	val finishedChilds = new ArrayList<IExecutionNode>

	val exceptionChilds = new ArrayList<IExecutionNode>

	override notifyChildReady(IExecutionNode node) {
		if (node == null) {
			throw new NullPointerException("Node can't be null")
		}
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
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
			protectIndexOverflow()
		} else {
			state.set(IExecutionNode.BLOCKED)
			parent.get.notifyChildBlocked
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
			protectIndexOverflow()
		} else {
			if (!blockedChilds.empty) {
				state.set(IExecutionNode.BLOCKED)
				parent.get.notifyChildBlocked
			} else {
				if (exceptionChilds.empty) {
					state.set(IExecutionNode.SUCCESS)
					parent.get.notifyChildSuccess
				} else {
					// Should never happened
					state.set(IExecutionNode.EXCEPTION)
					parent.get.notifyChildException
				}
			}
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
			protectIndexOverflow()
		} else {
			if (!blockedChilds.empty) {
				state.set(IExecutionNode.BLOCKED)
				parent.get.notifyChildBlocked
			} else {
				state.set(IExecutionNode.EXCEPTION)
				parent.get.notifyChildException
			}
		}
	}

	/**
	 * Protect index overflow. Should be invoked after remove from child list.
	 */
	def protected void protectIndexOverflow() {
		index = index % childs.size
	}

}