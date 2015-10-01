package ru.agentlab.maia.execution

/**
 * Execution node than not contain executable action
 * but select one of it's child for delegate execution.
 * 
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IExecutionScheduler extends IExecutionNode {

	/**
	 * Policies that control backward notification of execution chain
	 * after execution atomic action.
	 */
	enum Policy {

		/**
		 * The policy means that the scheduler should select next node
		 * and next time skip current child node.
		 */
		SKIP,

		/**
		 * The policy means that the scheduler should select next node.
		 */
		SCHEDULING,

		/**
		 * The policy means that the scheduler should do nothing at all.
		 */
		IDLE,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode.State#BLOCKED BLOCKED}.
		 */
		BLOCKED,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode.State#SUCCESS SUCCESS}.
		 */
		SUCCESS,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode.State#FAILED FAILED}.
		 */
		FAILED,

		/**
		 * The policy means that the scheduler should be restarted.
		 */
		RESTART,

		/**
		 * The policy means that the scheduler should be deleted.
		 */
		DELETED
	}

	val public static long RETRIES_INFINITE = -1L

	val public static long RETRIES_ONE_TIME = 1L

	/**
	 * Get all child nodes.
	 * 
	 * @return					all child nodes as Iterable.
	 */
	def Iterable<IExecutionNode> getChilds()

	/**
	 * Add specified child node to child nodes list.
	 * 
	 * @param node				node to be added.
	 * @throws					NullPointerException
	 * 							if node argument is {@code null}.
	 */
	def void addChild(IExecutionNode node)

	/**
	 * Remove specified child node from child nodes list.
	 * 
	 * @param node				node to be removed.
	 * @return					boolean flag of removing.
	 * @throws					NullPointerException
	 * 							if node argument is {@code null}.
	 * @throws 					IllegalArgumentException
	 * 							if specified node doesn't contains 
	 * 							in child node list.
	 */
	def boolean removeChild(IExecutionNode node)

	/**
	 * Clear child nodes list.
	 */
	def void removeAll()

	/**
	 * Notifies that specified child node asynchronously change state
	 * to {@link IExecutionNode.State#READY READY}.
	 * 
	 * @param node				node that changed state.
	 */
	def void notifyChildReady(IExecutionNode node)

	/**
	 * Notifies that the current child node was executed and it's state
	 * changed to {@link IExecutionNode.State#BLOCKED BLOCKED}.
	 */
	def void notifyChildBlocked()

	/**
	 * Notifies that the current child node was executed and it's state
	 * changed to {@link IExecutionNode.State#SUCCESS SUCCESS}.
	 */
	def void notifyChildSuccess()

	/**
	 * Notifies that the current child node was executed and it's state
	 * changed to {@link IExecutionNode.State#FAILED FAILED}.
	 */
	def void notifyChildFailed()

	/**
	 * <p>
	 * Notifies that the current child node scheduled to next node.
	 * </p><p>
	 * Current node should be a scheduler.
	 * </p>
	 */
	def void notifyChildScheduled()

	/**
	 * <p>
	 * Notifies that the current child was received some notification from 
	 * it's own child but did nothing. It is needed only for notifying
	 * parent scheduler about child notification.
	 * </p><p>
	 * For reacting on that notification "Child Idle Policy" is used.
	 * </p><p>
	 * Current node should be a scheduler.
	 * </p>
	 * @see State#IDLE State.IDLE
	 * @see #getChildIdlePolicy() getChildIdlePolicy()
	 * @see #setChildIdlePolicy(State) setChildIdlePolicy(State)
	 */
	def void notifyChildIdle()

	def long getMaxRetries()

	def void setMaxRetries(long newiterations)

	def Policy getChildBlockedPolicy()

	def void setChildBlockedPolicy(Policy newPolicy)

	def Policy getChildFailedPolicy()

	def void setChildFailedPolicy(Policy newPolicy)

	def Policy getChildSuccessPolicy()

	def void setChildSuccessPolicy(Policy newPolicy)

	def Policy getChildScheduledPolicy()

	def void setChildScheduledPolicy(Policy newPolicy)

	def Policy getChildIdlePolicy()

	def void setChildIdlePolicy(Policy newPolicy)

	def Policy getSchedulerFinishedPolicy()

	def void setSchedulerFinishedPolicy(Policy newPolicy)

	def void reset()

	def void restart()

}