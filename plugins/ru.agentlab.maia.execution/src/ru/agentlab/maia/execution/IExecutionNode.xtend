package ru.agentlab.maia.execution

interface IExecutionNode extends IStateFull<IExecutionNode> {

	/**
	 * Indicate that current node isn't ready for execution by some worker.
	 */
	val public static String UNKNOWN = "UNKNOWN"

	/**
	 * Indicate that current node is ready for execution by some worker.
	 */
	val public static String READY = "READY"

	/**
	 * Indicate that current node is handled by some worker.
	 */
	val public static String IN_WORK = "IN_WORK"

	/**
	 * Indicate that current node was handled and now is waiting for some external event.
	 */
	val public static String WAITING = "WAITING"

	/**
	 * Indicate that current node execution was finished.
	 */
	val public static String FINISHED = "FINISHED"

	/**
	 * Indicate that current node execution was performed with exception.
	 */
	val public static String EXCEPTION = "EXCEPTION"

	def void run()

	// --------------------------------------------
	// Inputs manipulations
	// --------------------------------------------
	def Iterable<IExecutionInput<?>> getInputs()

	def void addInput(IExecutionInput<?> input)

	def void removeInput(IExecutionInput<?> input)

	// --------------------------------------------
	// Outputs manipulations
	// --------------------------------------------
	def Iterable<IExecutionOutput<?>> getOutputs()

	def void addOutput(IExecutionOutput<?> output)

	def void removeOutput(IExecutionOutput<?> output)

}