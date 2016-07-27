package ru.agentlab.maia.organization

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class ProtocolRegistry {

	val protocols = new ArrayList<IProtocol>

}