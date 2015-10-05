package ru.agentlab.maia.execution

interface ITask {

	enum State {

		/**
		 * <p>Indicate that current node isn't ready for execution by some worker.</p>
		 */
		UNKNOWN,

		/**
		 * <p>Indicate that current node is ready for execution by some worker.</p>
		 */
		READY,

		/**
		 * <p>Indicate that current node is handled by some worker.</p>
		 */
		WORKING,

		/**
		 * <p>Indicate that current node was handled and now is waiting for some external event.</p>
		 */
		BLOCKED,

		/**
		 * <p>Indicate that current node execution was finished successfully.</p>
		 */
		SUCCESS,

		/**
		 * <p>Indicate that current node execution was performed with exception.</p>
		 */
		FAILED
	}

	/**
	 * <p>Invoke one step of execution of the task.</p>
	 */
	def void execute()

	/**
	 * <p>Retrieve task parent.</p>
	 * 
	 * @return 					task parent.
	 */
	def ITaskScheduler getParent()

	/**
	 * <p>Change task parent. Automatically register task as subtask of parent.</p>
	 * 
	 * @param parent			parent task.
	 */
	def void setParent(ITaskScheduler parent)

	/**
	 * <p>Retrieve task state.</p>
	 * 
	 * @return 					task state.
	 */
	def State getState()

	/**
	 * <p>Retrieve all task inputs.</p>
	 * 
	 * @return 					collection of task inputs or
	 * 							{@code null} if task have no inputs.
	 */
	def Iterable<ITaskParameter<?>> getInputs()

	/**
	 * <p>Retrieve all task outputs.</p>
	 * 
	 * @return 					collection of task outputs or
	 * 							{@code null} if task have no outputs.
	 */
	def Iterable<ITaskParameter<?>> getOutputs()

	/**
	 * <p>Add specified parameter as input to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addInput(ITaskParameter<?> parameter)

	/**
	 * <p>Add specified parameter as output to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addOutput(ITaskParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task inputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeInput(ITaskParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task outputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeOutput(ITaskParameter<?> parameter)

	/**
	 * <p>Remove all parameters from task inputs.</p>
	 */
	def void clearInputs()

	/**
	 * <p>Remove all parameters from task outputs.</p>
	 */
	def void clearOutputs()

	/**
	 * <p>Reset task to initial state.</p>
	 */
	def void reset()

}