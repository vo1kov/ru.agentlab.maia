package ru.agentlab.maia.execution

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

	boolean isReady = false

	/**
	 * <p>Scheduler in context hierarchy</p>
	 * <p>Can be <code>null</code> if no schedulers in parent contexts. </p>
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

	def void setReady(boolean newState) {
		if (!isReady && newState) {
			parentScheduler = context.parent.get(IMaiaExecutorScheduler)
			parentScheduler?.add(this)
		} else if (isReady && !newState) {
			parentScheduler?.remove(this)
			parentScheduler = null
		}
		isReady = newState
	}

}