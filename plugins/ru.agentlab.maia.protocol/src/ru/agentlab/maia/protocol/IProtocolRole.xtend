package ru.agentlab.maia.protocol

interface IProtocolRole {

	enum Cardinality {
		SINGLE,
		MULTIPLE
	}

	def String getName()

	def void setName(String name)

	def IContextSchedulerScheme getBehaviourScheme()

	def void setBehaviourScheme(IContextSchedulerScheme scheme)

	def Cardinality getCardinality()

}