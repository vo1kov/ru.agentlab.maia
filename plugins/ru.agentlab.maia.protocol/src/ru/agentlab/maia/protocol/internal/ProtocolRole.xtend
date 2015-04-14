package ru.agentlab.maia.protocol.internal

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.protocol.IProtocolRole

@Accessors
class ProtocolRole implements IProtocolRole {

	String name

	IContextSchedulerScheme behaviourScheme

	Cardinality cardinality = Cardinality.SINGLE

	new(String name, IContextSchedulerScheme behaviourScheme, Cardinality cardinality) {
		this.name = name
		this.behaviourScheme = behaviourScheme
		this.cardinality = cardinality
	}

}