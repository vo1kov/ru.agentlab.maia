package ru.agentlab.maia.execution.tree

interface IExecutionNode {
	
	val public static int UNKNOWN = -1
	
	val public static int INSTALLED = 1
	
	val public static int ACTIVE = 3
	
	val public static int BLOCKED = 5
	
	val public static int SUSPENDED = 7

	def void run()

	def IExecutionScheduler getParent()

	def int getState()
	
	def void block()
	
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