package ru.agentlab.maia.protocol

interface IProtocolRole {

	enum Cardinality {
		SINGLE,
		MULTIPLE
	}

	def String getName()

	def void setName(String name)

//	def IMaiaExecutorSchedulerScheme getSchedulerScheme()
//
//	def void setSchedulerScheme(IMaiaExecutorSchedulerScheme scheme)

	def Cardinality getCardinality()

}