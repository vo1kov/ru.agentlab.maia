package ru.agentlab.maia.execution.tree

interface IDataOutputParameter<T> extends IDataParameter<T> {
	
	def Iterable<IDataParameter<T>> getLinked()
	
	def void addLinked(IDataParameter<T> param)
	
}