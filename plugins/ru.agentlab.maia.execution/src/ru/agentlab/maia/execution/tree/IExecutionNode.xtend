package ru.agentlab.maia.execution.tree

interface IExecutionNode {

	def void run()

	def IExecutionScheduler getParent()

	def ExecutionNodeState getState()

	def Iterable<IDataInputParameter<?>> getInputs()

	def Iterable<IDataOutputParameter<?>> getOutputs()

	def void addParameter(IDataParameter<?> parameter)

	def void addInput(IDataInputParameter<?> input)

	def void addOutput(IDataOutputParameter<?> output)

	def void removeParameter(IDataParameter<?> parameter)

	def void removeInput(IDataInputParameter<?> input)

	def void removeOutput(IDataOutputParameter<?> output)

	def IDataParameter<?> getParameter(String name)

	def IDataInputParameter<?> getInput(String name)

	def IDataOutputParameter<?> getOutput(String name)

}