package ru.agentlab.maia.execution

interface IExecutionNode {

	/**
	 * Indicate that current node isn't ready for execution by some worker.
	 */
	val public static byte UNKNOWN = (-1) as byte

	/**
	 * Indicate that current node is ready for execution by some worker.
	 */
	val public static byte READY = 1 as byte

	/**
	 * Indicate that current node is handled by some worker.
	 */
	val public static byte IN_WORK = 3 as byte

	/**
	 * Indicate that current node was handled and now is waiting for some external event.
	 */
	val public static byte BLOCKED = 5 as byte

	/**
	 * Indicate that current node execution was finished.
	 */
	val public static byte SUCCESS = 11 as byte

	/**
	 * Indicate that current node execution was performed with exception.
	 */
	val public static byte EXCEPTION = 13 as byte

	/**
	 * <p>
	 * Invoke 1 step of execution of the node.
	 * </p><p>
	 * There are 2 kind of execution nodes:
	 * </p><ul>
	 * <li>{@link IExecutionScheduler} - delegate to one of child node.</li>
	 * <li>{@link IExecutionAction} - perform action and notify parent 
	 * about result of execution.</li>
	 * </ul>
	 */
	def void run()

	def IExecutionScheduler getParent()

	def void setParent(IExecutionScheduler parent)

	def byte getState()

	def Iterable<IExecutionParameter<?>> getInputs()

	def void addInput(IExecutionParameter<?> input)

	def void removeInput(IExecutionParameter<?> input)

	def void removeAllInputs()

	def Iterable<IExecutionParameter<?>> getOutputs()

	def void addOutput(IExecutionParameter<?> output)

	def void removeOutput(IExecutionParameter<?> output)

	def void removeAllOutputs()

	def void reset()

}