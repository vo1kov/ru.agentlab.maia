package org.maia.protocol

import org.maia.task.scheduler.scheme.IBehaviourScheme

interface IProtocolRole {

	enum Cardinality {
		SINGLE,
		MULTIPLE
	}

	def String getName()

	def void setName(String name)

	def IBehaviourScheme getBehaviourScheme()

	def void setBehaviourScheme(IBehaviourScheme scheme)

	def Cardinality getCardinality()

}