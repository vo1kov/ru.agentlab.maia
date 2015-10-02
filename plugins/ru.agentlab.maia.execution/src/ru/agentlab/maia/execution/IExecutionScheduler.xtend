package ru.agentlab.maia.execution

/**
 * <p>Execution node than delegate execution to one of child nodes.</p>
 * 
 * <h2>Child state change notification</h2>
 * <p>After executing any child node scheduler should know a new state of
 * that node for further scheduling. For this purpose child should notify 
 * its parent about changing its state.</p>
 * 
 * <p>There are possible notifications:</p>
 * <ul>
 * <li>{@link #notifyChildSuccess() notifyChildSuccess()} - when node finished 
 * successfully.</li>
 * <li>{@link #notifyChildBlocked() notifyChildBlocked()} - when node wait 
 * some external event for continue.</li>
 * <li>{@link #notifyChildFailed() notifyChildFailed()} - when node finished 
 * with some exception.</li>
 * <li>{@link #notifyChildWorking() notifyChildWorking()} - when node still working
 * and need more iterations to complete the task.</li>
 * <li>{@link #notifyChildReady(IExecutionNode) notifyChildReady()} - 
 * when node became ready for execution.</li>
 * </ul>
 * 
 * <h2>Reacting on child notifications</h2>
 * <p>Depending on the requirements of scheduler behavior there are some
 * possible variants of reacting on child notification. Reactions are configured
 * for every scheduler instance by {@link Policy Policy} - some flag indicating 
 * how exactly react on child notification.</p>
 *  
 * @author <a href='shishkindimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IExecutionScheduler extends IExecutionNode {

	/**
	 * <p>Policy that control reaction on notification.</p>
	 */
	enum Policy {

		/**
		 * <p>The policy means that the scheduler should select next node and next 
		 * time skip current child node and notify own parent that is
		 * still working.</p>
		 */
		SKIP,

		/**
		 * <p>The policy means that the scheduler should select next node and 
		 * notify own parent that is still working.</p>
		 */
		SCHEDULING,

		/**
		 * <p>The policy means that the scheduler should do nothing, wait some 
		 * another notification from child node and notify own parent that 
		 * is still working.</p>
		 */
		IDLE,

		/**
		 * <p>The policy means that the scheduler should wait notification that 
		 * some child node become ready and notify parent that is waiting.</p>
		 */
		BLOCKED,

		/**
		 * <p>The policy means that the scheduler successfully finish its work 
		 * and should notify own parent about it.</p>
		 */
		SUCCESS,

		/**
		 * <p>The policy means that the scheduler can't execute other subtasks 
		 * and should notify own parent about it.</p>
		 */
		FAILED,

		/**
		 * <p>The policy means that the scheduler should try to restart 
		 * execution of its child nodes and notify own parent that is
		 * still working.</p>
		 */
		RESTART,

		/**
		 * <p>The policy means that the scheduler should be deleted from its 
		 * own parent.</p>
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
	def void notifyChildWorking()

	def long getMaxRetries()

	def void setMaxRetries(long newiterations)

	def Policy getChildBlockedPolicy()

	def void setChildBlockedPolicy(Policy newPolicy)

	def Policy getChildFailedPolicy()

	def void setChildFailedPolicy(Policy newPolicy)

	def Policy getChildSuccessPolicy()

	def void setChildSuccessPolicy(Policy newPolicy)

	def Policy getChildWorkingPolicy()

	def void setChildWorkingPolicy(Policy newPolicy)

	def Policy getSomeChildsSkipedPolicy()

	def void setSomeChildsSkipedPolicy(Policy newPolicy)

	def Policy getNoChildsSkipedPolicy()

	def void setNoChildsSkipedPolicy(Policy newPolicy)

	def void reset()

	def void restart()

}