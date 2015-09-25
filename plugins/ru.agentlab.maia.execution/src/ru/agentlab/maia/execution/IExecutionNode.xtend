package ru.agentlab.maia.execution

interface IExecutionNode {

	def Iterable<IExecutionParameter<?>> getInputs()

	def void addInput(IExecutionParameter<?> input)

	def void removeInput(IExecutionParameter<?> input)

	def void removeAllInputs()

	def Iterable<IExecutionParameter<?>> getOutputs()

	def void addOutput(IExecutionParameter<?> output)

	def void removeOutput(IExecutionParameter<?> output)

	def void removeAllOutputs()

	def boolean isDone()
	
	def void reset()

}