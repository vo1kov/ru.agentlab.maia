package ru.agentlab.maia.execution.tree

interface IExecutionNode {

	def void run()

	def IExecutionScheduler getParent()

	def ExecutionNodeState getState()
	
	def void deactivate()
	
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