package org.maia.protocol.internal

import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.protocol.IProtocolRole
import org.maia.task.scheduler.scheme.IBehaviourScheme

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