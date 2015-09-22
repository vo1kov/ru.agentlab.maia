package ru.agentlab.maia.execution.tree

interface IExecutionNode {

	/**
	 * Indicate that current node isn't ready for execution by some worker.
	 */
	val public static int UNKNOWN = -1

	/**
	 * Indicate that current node is ready for execution by some worker.
	 */
	val public static int READY = 1

	/**
	 * Indicate that current node is handled by some worker.
	 */
	val public static int IN_WORK = 3

	/**
	 * Indicate that current node was handled and now is waiting for some external event.
	 */
	val public static int WAITING = 5

	/**
	 * Indicate that current node execution was finished.
	 */
	val public static int FINISHED = 11

	/**
	 * Indicate that current node execution was performed with exception.
	 */
	val public static int EXCEPTION = 11

	def void run()

	def IExecutionScheduler getParent()

	def void setParent(IExecutionScheduler parent)

	def int getState()

	/**
	 * Retrieve repeat count - the number of completed runs before node 
	 * will be considered to be finished.
	 */
	def int getRepeatCounts()

	/**
	 * Change repeat count
	 */
	def void setRepeatCounts(int count)

	def Iterable<IDataInputParameter<?>> getInputs()

	def Iterable<IDataOutputParameter<?>> getOutputs()

	def void addInput(IDataInputParameter<?> input)

	def void addOutput(IDataOutputParameter<?> output)

	def void removeInput(IDataInputParameter<?> input)

	def void removeOutput(IDataOutputParameter<?> output)

	def IDataInputParameter<?> getInput(String name)

	def IDataOutputParameter<?> getOutput(String name)
	
	def int setState(int newState)
	
	def void handleParameterChangedState(IDataParameter<?> parameter, int oldState, int newState)
	
//	/**
//	 * Change execution state to READY and notify parent
//	 */
//	def int setUnknownState()
//
//	def int setReadyState()
//
//	def int setInWorkState()
//
//	def int setWaitingState()
//
//	def int setFinishedState()

//	def void handleParameterEmpty(IDataParameter<?> param)
//
//	def void handleParameterLink(IDataParameter<?> param)

}