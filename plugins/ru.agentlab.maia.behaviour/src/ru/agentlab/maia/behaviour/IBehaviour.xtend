package ru.agentlab.maia.behaviour

interface IBehaviour extends IExecutionStep {

	def String getLabel()
	
	def void setLabel(String newLabel)

	/**
	 * <p>Invoke one step of execution of the task.</p>
	 */
	def void execute()

	/**
	 * <p>Retrieve task parent.</p>
	 * 
	 * @return 					task parent.
	 */
	def IBehaviourScheduler getParent()

	/**
	 * <p>Change task parent. Automatically register task as subtask of parent.</p>
	 * 
	 * @param parent			parent task.
	 */
	def void setParent(IBehaviourScheduler parent)

	/**
	 * <p>Retrieve task state.</p>
	 * 
	 * @return 					task state.
	 */
	def BehaviourState getState()

	/**
	 * <p>Change task state.</p>
	 * 
	 * @param parent			new task state.
	 * @return 					previous task state.
	 */
	def void setState(BehaviourState newState)

	/**
	 * <p>Retrieve all task inputs.</p>
	 * 
	 * @return 					collection of task inputs or
	 * 							{@code null} if task have no inputs.
	 */
	def Iterable<IBehaviourParameter<?>> getInputs()

	/**
	 * <p>Retrieve all task outputs.</p>
	 * 
	 * @return 					collection of task outputs or
	 * 							{@code null} if task have no outputs.
	 */
	def Iterable<IBehaviourParameter<?>> getOutputs()

	/**
	 * <p>Add specified parameter as input to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addInput(IBehaviourParameter<?> parameter)

	/**
	 * <p>Add specified parameter as output to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addOutput(IBehaviourParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task inputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeInput(IBehaviourParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task outputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeOutput(IBehaviourParameter<?> parameter)

	/**
	 * <p>Remove all parameters from task inputs.</p>
	 */
	def void clearInputs()

	/**
	 * <p>Remove all parameters from task outputs.</p>
	 */
	def void clearOutputs()
	
	def Iterable<IBehaviourException> getExceptions()
	
	def void addException(IBehaviourException exception)
	
	def void removeException(IBehaviourException exception)
	
	def void clearExceptions()

	/**
	 * <p>Reset task to initial state.</p>
	 */
//	def void reset()

}