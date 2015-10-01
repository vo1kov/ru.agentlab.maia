package ru.agentlab.maia.execution

interface IExecutionNode {

	enum State {

		/**
		 * Indicate that current node isn't ready for execution by some worker.
		 */
		UNKNOWN,

		/**
		 * Indicate that current node is ready for execution by some worker.
		 */
		READY,

		/**
		 * Indicate that current node is handled by some worker.
		 */
		WORKING,

		/**
		 * Indicate that current node was handled and now is waiting for some external event.
		 */
		BLOCKED,

		/**
		 * Indicate that current node execution was finished successfully.
		 */
		SUCCESS,

		/**
		 * Indicate that current node execution was performed with exception.
		 */
		FAILED
	}

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

	def State getState()

	def Iterable<IExecutionParameter<?>> getInputs()

	def void addInput(IExecutionParameter<?> input)

	def void removeInput(IExecutionParameter<?> input)

	def void removeAllInputs()

	def Iterable<IExecutionParameter<?>> getOutputs()

	def void addOutput(IExecutionParameter<?> output)

	def void removeOutput(IExecutionParameter<?> output)

	def void removeAllOutputs()

}