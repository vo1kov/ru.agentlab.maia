package ru.agentlab.maia.execution

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
	val public static int BLOCKED = 5

	/**
	 * Indicate that current node execution was finished.
	 */
	val public static int SUCCESS = 11

	/**
	 * Indicate that current node execution was performed with exception.
	 */
	val public static int EXCEPTION = 13
	
	def IExecutionScheduler getParent()

	def void setParent(IExecutionScheduler parent)
	
	def int getState()

	def Iterable<IExecutionParameter<?>> getInputs()

	def void addInput(IExecutionParameter<?> input)

	def void removeInput(IExecutionParameter<?> input)

	def void removeAllInputs()

	def Iterable<IExecutionParameter<?>> getOutputs()

	def void addOutput(IExecutionParameter<?> output)

	def void removeOutput(IExecutionParameter<?> output)

	def void removeAllOutputs()

//	def boolean isDone()
//	
	def void reset()

}