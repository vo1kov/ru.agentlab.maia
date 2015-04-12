package ru.agentlab.maia.protocol.internal

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.protocol.IProtocol

@Accessors
class ProtocolRegistry {

	val protocols = new ArrayList<IProtocol>

}