package ru.agentlab.maia.execution.tree

interface IDataLink {

	def IDataParameter<?> getFrom()

	def void setFrom(IDataParameter<?> from)

	def IDataParameter<?> getTo()

	def void setTo(IDataParameter<?> to)

	def String getKey()

	def void setKey(String key)

}