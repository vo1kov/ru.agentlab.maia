package ru.agentlab.maia.execution

interface IExecutionScheduler extends IExecutionNode {

	enum Policy {

		/**
		 * The policy means that the scheduler should skip child node while 
		 * select next node.
		 */
		SKIP,

		/**
		 * The policy means that the scheduler should do nothing and select next node.
		 */
		WORKING,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode#STATE_BLOCKED BLOCKED}.
		 */
		BLOCKED,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode#STATE_SUCCESS SUCCESS}.
		 */
		SUCCESS,

		/**
		 * The policy means that the scheduler should become 
		 * {@link IExecutionNode#STATE_FAILED FAILED}.
		 */
		FAILED,

		/**
		 * The policy means that the scheduler should be restarted.
		 */
		RESTART
	}

	val public static long RETRIES_INFINITE = -1L

	val public static long RETRIES_ONE_TIME = 1L

	def Iterable<IExecutionNode> getChilds()

	def void addChild(IExecutionNode node)

	def boolean removeChild(IExecutionNode node)

	def void removeAll()

	def void notifyChildReady(IExecutionNode node)

	def void notifyChildBlocked()

	def void notifyChildSuccess()

	def void notifyChildFailed()

	def long getMaxRetries()

	def void setMaxRetries(long newiterations)

	def Policy getChildBlockedPolicy()

	def void setChildBlockedPolicy(Policy newPolicy)

	def Policy getChildFailedPolicy()

	def void setChildFailedPolicy(Policy newPolicy)

	def Policy getChildSuccessPolicy()

	def void setChildSuccessPolicy(Policy newPolicy)

	def Policy getSchedulerFinishedPolicy()

	def void setSchedulerFinishedPolicy(Policy newPolicy)

	def void reset()

	def void restart()

}