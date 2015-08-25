package ru.agentlab.maia.execution.tree

interface IDataParameter {
	
	enum Direction{
		INPUT, OUTPUT
	}
	
	def String getName()
	
	def String getKey()
	
	def Direction getDirection()
	
	def void setKey(String key)
	
	def <T> Class<T> getType()
	
}