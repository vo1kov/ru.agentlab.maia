package ru.agentlab.maia.execution

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

/**
 * Scheduler - is a execution node that returns next node in tree.
 * Algorithm of calculation of next node is depends of scheduler implementation.
 * Scheduler has lazy registration in parent scheduler. It register self only when
 * first child node is registered. When last node removed scheduler try to remove
 * self from parent scheduler.
 * @see getNextNode()
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
abstract class AbstractScheduler implements IMaiaExecutorScheduler {

	@Inject
	protected IMaiaContext context

	/**
	 * Queue of available nodes.
	 */
	protected List<IMaiaExecutorNode> nodes = new ArrayList<IMaiaExecutorNode>

	/**
	 * <p>Scheduler in context hierarchy</p>
	 * <p>Can be <code>null</code>.</p>
	 */
	protected IMaiaExecutorScheduler parentScheduler = null

	/**
	 * Initialization of scheduler.
	 * Clear previous scheduler in context if exists.
	 */
	@PostConstruct
	def void init() {
		val oldScheduler = context.getLocal(IMaiaExecutorScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}
	}

	/**
	 * <p>Add a context at the end of the nodes queue.</p>
	 * 
	 * <p>When you add a node to scheduler first time it try to update parent scheduler and add self
	 * to parent scheduler.</p>
	 * 
	 * @param
	 * 		node - node to be added from scheduler.
	 */
	override synchronized void add(IMaiaExecutorNode node) {
		if (nodes.empty) {
			parentScheduler = context.parent.get(IMaiaExecutorScheduler)
		}
		if (!nodes.contains(node)) {
			nodes += node
			parentScheduler?.add(this)
		}
	}

	/**
	 * <p>Removes a specified node from the nodes queue.</p>
	 * 
	 * <p>When remove last node it removes self from parent scheduler and forget about parent scheduler.
	 * It is necessary to avoid changes in hierarchy of contexts when scheduler is inactive.</p>
	 * 
	 * @param
	 * 		node - node to be removed from scheduler.
	 */
	override synchronized void remove(IMaiaExecutorNode node) {
		if (nodes.contains(node)) {
			nodes.remove(node)
			if (empty) {
				parentScheduler?.remove(this)
				parentScheduler = null
			}
		}
	}

	/** 
	 * Removes all contexts from the nodes queue and removes self from parent scheduler.
	 */
	override synchronized void removeAll() {
		nodes.clear
		parentScheduler?.remove(this)
		parentScheduler = null
	}

	override synchronized isEmpty() {
		return nodes.empty
	}

	override abstract getNextNode()

}