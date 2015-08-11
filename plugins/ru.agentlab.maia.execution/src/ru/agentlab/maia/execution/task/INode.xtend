package ru.agentlab.maia.execution.task

interface INode {

	def Object run()

//	def INodeParameter[] getInputs()

	def IParameter getInput(String name)
	
	def void addInput(IParameter input)
	
	def void removeInput(IParameter input)

//	def INodeParameter[] getOutputs()

	def IParameter getOutput(String name)

	def void addOutput(IParameter output)
	
	def void removeOutput(IParameter output)

}