package ru.agentlab.maia.protocol.internal

import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.protocol.IProtocolRole

@Accessors
class ProtocolRole implements IProtocolRole {

	String name

//	IMaiaExecutorSchedulerScheme schedulerScheme
	Cardinality cardinality = Cardinality.SINGLE

//	new(String name, IMaiaExecutorSchedulerScheme schedulerScheme, Cardinality cardinality) {
//		this.name = name
//		this.schedulerScheme = schedulerScheme
//		this.cardinality = cardinality
//	}
}