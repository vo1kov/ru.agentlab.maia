package ru.agentlab.maia.protocol.internal

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.protocol.IProtocolRole
import ru.agentlab.maia.protocol.IProtocolRole.Cardinality
import ru.agentlab.maia.behaviour.scheme.IContextSchedulerScheme

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