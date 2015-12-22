package ru.agentlab.maia.behaviour

import java.util.UUID

/**
 * 
 * @author Dmitry Shishkin
 */
interface IBehaviour {

	def UUID getUuid()
	
	/**
	 * <p>Invoke one step of execution of the task.</p>
	 */
	def void execute() throws Exception

	/**
	 * <p>Retrieve task state.</p>
	 * 
	 * @return 					task state.
	 */
	def BehaviourState getState()

	/**
	 * <p>Retrieve all task inputs.</p>
	 * 
	 * @return 					collection of task inputs or
	 * 							{@code null} if task have no inputs.
	 */
	def Iterable<BehaviourParameter<?>> getInputs()

	/**
	 * <p>Retrieve all task outputs.</p>
	 * 
	 * @return 					collection of task outputs or
	 * 							{@code null} if task have no outputs.
	 */
	def Iterable<BehaviourParameter<?>> getOutputs()

	/**
	 * <p>Add specified parameter as input to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addInput(BehaviourParameter<?> parameter)

	/**
	 * <p>Add specified parameter as output to task.</p>
	 * 
	 * @param parameter			parameter to be added.
	 */
	def void addOutput(BehaviourParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task inputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeInput(BehaviourParameter<?> parameter)

	/**
	 * <p>Remove specified parameter from task outputs.</p>
	 * 
	 * @param parameter			parameter to be removed.
	 */
	def void removeOutput(BehaviourParameter<?> parameter)

	/**
	 * <p>Remove all parameters from task inputs.</p>
	 */
	def void clearInputs()

	/**
	 * <p>Remove all parameters from task outputs.</p>
	 */
	def void clearOutputs()

	def Iterable<BehaviourException<?>> getExceptions()

	def void addException(BehaviourException<?> exception)

	def void removeException(BehaviourException<?> exception)

	def void clearExceptions()

///**
// * <p>Reset task to initial state.</p>
// */
//	def void reset()
}