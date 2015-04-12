package ru.agentlab.maia.protocol

import ru.agentlab.maia.behaviour.scheme.IContextSchedulerScheme

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