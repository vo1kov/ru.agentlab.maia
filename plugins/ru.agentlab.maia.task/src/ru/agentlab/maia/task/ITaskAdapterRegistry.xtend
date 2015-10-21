package ru.agentlab.maia.task

interface ITaskAdapterRegistry {
	
	def ITaskAdapter<?> getAdapter(String id) 
	
	def void putAdapter(String id, ITaskAdapter<?> adapter)
	
	def void removeAdapter(String id)
	
}