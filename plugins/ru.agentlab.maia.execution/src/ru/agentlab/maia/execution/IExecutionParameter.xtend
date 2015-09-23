package ru.agentlab.maia.execution

interface IExecutionParameter<T> {

	/**
	 * Indicate that current parameter isn't ready for execution by some worker.
	 */
	val public static int DISCONNECTED = -1

	/**
	 * Indicate that current parameter .
	 */
	val public static int CONNECTED = 1

	def String getName()

	def T getValue()

	def void setValue(T value)

	def <T> Class<T> getType()

	def boolean isOptional()

	def void connect(IExecutionInput<T> input)

	def void connect(IExecutionOutput<T> output)

	def void disconnect(IExecutionInput<T> input)

	def void disconnect(IExecutionOutput<T> output)

	def void changeStateConnected()

	def void changeStateDisconnected()

	def boolean isConnected()

	def boolean isDisconnected()

}