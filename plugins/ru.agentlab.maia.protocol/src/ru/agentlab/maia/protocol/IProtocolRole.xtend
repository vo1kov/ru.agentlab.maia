package ru.agentlab.maia.protocol

import ru.agentlab.maia.execution.scheduler.scheme.IMaiaExecutorSchedulerScheme

interface IProtocolRole {

	enum Cardinality {
		SINGLE,
		MULTIPLE
	}

	def String getName()

	def void setName(String name)

	def IMaiaExecutorSchedulerScheme getSchedulerScheme()

	def void setSchedulerScheme(IMaiaExecutorSchedulerScheme scheme)

	def Cardinality getCardinality()

}