package ru.agentlab.maia.internal.protocol

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.sheme.IBehaviourScheme
import ru.agentlab.maia.protocol.IProtocolRole

@Accessors
class ProtocolRole implements IProtocolRole {

	String name

	IBehaviourScheme behaviourScheme

	Cardinality cardinality = Cardinality.SINGLE

	new(String name, IBehaviourScheme behaviourScheme, Cardinality cardinality) {
		this.name = name
		this.behaviourScheme = behaviourScheme
		this.cardinality = cardinality
	}

}