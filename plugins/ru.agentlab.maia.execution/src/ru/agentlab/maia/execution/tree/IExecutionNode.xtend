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

	def void run()

	def IExecutionScheduler getParent()

	def void setParent(IExecutionScheduler parent)

	def int getState()

	/**
	 * Change execution state to WAITING and notify parent
	 */
	def void block()

	/**
	 * Change execution state to READY and notify parent
	 */
	def void activate()

	def Iterable<IDataInputParameter<?>> getInputs()

	def Iterable<IDataOutputParameter<?>> getOutputs()

	def void addInput(IDataInputParameter<?> input)

	def void addOutput(IDataOutputParameter<?> output)

	def void removeInput(IDataInputParameter<?> input)

	def void removeOutput(IDataOutputParameter<?> output)

	def IDataInputParameter<?> getInput(String name)

	def IDataOutputParameter<?> getOutput(String name)

}