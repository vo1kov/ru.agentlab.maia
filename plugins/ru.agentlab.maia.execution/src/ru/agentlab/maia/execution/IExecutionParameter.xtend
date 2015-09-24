package ru.agentlab.maia.execution

interface IExecutionParameter<T> extends IStateFull<IExecutionParameter<T>> {

	/**
	 * Indicate that current parameter isn't ready for execution by some worker.
	 */
	val public static String UNLINKED = "UNLINKED"

	/**
	 * Indicate that current parameter .
	 */
	val public static String LINKED = "LINKED"
	
	def String getName()

	def T getValue()

	def void setValue(T value)

	def <T> Class<T> getType()

	def boolean isOptional()

	def void link(IExecutionParameter<T> param)

	def void unlink(IExecutionParameter<T> param)
	
	def Iterable<IExecutionParameter<T>> getLinked()

}