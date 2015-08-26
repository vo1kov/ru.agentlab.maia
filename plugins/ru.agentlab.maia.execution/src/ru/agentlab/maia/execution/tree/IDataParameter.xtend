package ru.agentlab.maia.execution.tree

interface IDataParameter<T> {
	
	def String getName()
	
	def String getKey()
	
	def void setKey(String key)
	
	def <T> Class<T> getType()
	
}