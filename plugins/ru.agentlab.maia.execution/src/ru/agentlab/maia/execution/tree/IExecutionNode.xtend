package ru.agentlab.maia.execution.tree

interface IExecutionNode {

	def Object run()

//	def INodeParameter[] getInputs()
	def IDataParameter getInput(String name)

	def void addInput(IDataParameter input)

	def void removeInput(IDataParameter input)

//	def INodeParameter[] getOutputs()
	def IDataParameter getOutput(String name)

	def void addOutput(IDataParameter output)

	def void removeOutput(IDataParameter output)

}