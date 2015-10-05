package ru.agentlab.maia.execution

/**
 * <p>Execution node than delegate execution to one of subtasks.</p>
 * 
 * <h2>Child state change notification</h2>
 * <p>After executing any subtask scheduler should know a new state of
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
 * <li>{@link #notifyChildReady(ITask) notifyChildReady()} - 
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
interface ITaskScheduler extends ITask {

	/**
	 * <p>Policy that control reaction on notification.</p>
	 */
	enum Policy {

		/**
		 * <p>The policy means that the scheduler should select next node and next 
		 * time skip current subtask and notify own parent that is
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
		 * another notification from subtask and notify own parent that 
		 * is still working.</p>
		 */
		IDLE,

		/**
		 * <p>The policy means that the scheduler should wait notification that 
		 * some subtask become ready and notify parent that is waiting.</p>
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
		 * execution of its subtasks and notify own parent that is
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
	 * <p>Get all subtasks.</p>
	 * 
	 * @return					all subtasks as Iterable.
	 */
	def Iterable<ITask> getSubtasks()

	/**
	 * <p>Add specified task as subtask of current scheduler.</p>
	 * 
	 * @param task				task to be added.
	 * @throws					NullPointerException
	 * 							if task argument is {@code null}.
	 */
	def boolean addSubtask(ITask task)

	/**
	 * <p>Remove specified task from subtasks list.</p>
	 * 
	 * @param task				task to be removed.
	 * @return					boolean flag of removing.
	 * @throws					NullPointerException
	 * 							if task argument is {@code null}.
	 * @throws 					IllegalArgumentException
	 * 							if specified task doesn't contains 
	 * 							in subtasks list.
	 */
	def boolean removeSubtask(ITask task)

	/**
	 * <p>Notifies that specified task asynchronously changed state
	 * to {@link ITask.State#READY READY}.</p>
	 * 
	 * @param task				task that changed state.
	 */
	def void notifySubtaskReady(ITask task)

	/**
	 * <p>Notifies that the current subtask was executed and it's state
	 * changed to {@link ITask.State#BLOCKED BLOCKED}.</p>
	 */
	def void notifySubtaskBlocked()

	/**
	 * <p>Notifies that the current subtask was executed and it's state
	 * changed to {@link ITask.State#SUCCESS SUCCESS}.</p>
	 */
	def void notifySubtaskSuccess()

	/**
	 * <p>Notifies that the current subtask was executed and it's state
	 * changed to {@link ITask.State#FAILED FAILED}.</p>
	 */
	def void notifySubtaskFailed()

	/**
	 * <p>Notifies that the current child was received some notification from 
	 * it's own child but did nothing. It is needed only for notifying
	 * parent scheduler about child notification.</p>
	 * 
	 * <p>For reacting on that notification "Child Idle Policy" is used.</p>
	 * 
	 * <p>Current node should be a scheduler.</p>
	 */
	def void notifySubtaskWorking()

	def long getRetriesLimit()

	def void setRetriesLimit(long newiterations)

//	def Policy getPolicyOnChildBlocked()
//
//	def void setPolicyOnChildBlocked(Policy newPolicy)
//
//	def Policy getPolicyOnChildFailed()
//
//	def void setPolicyOnChildFailed(Policy newPolicy)
//
//	def Policy getPolicyOnChildSuccess()
//
//	def void setPolicyOnChildSuccess(Policy newPolicy)
//
//	def Policy getPolicyOnChildWorking()
//
//	def void setPolicyOnChildWorking(Policy newPolicy)
//
//	def Policy getPolicyOnAllChildsBlocked()
//
//	def void setPolicyOnAllChildsBlocked(Policy newPolicy)
//
//	def Policy getPolicyOnAllChildsSuccess()
//
//	def void setPolicyOnAllChildsSuccess(Policy newPolicy)

	def void restart()
	
	def void clear()

}