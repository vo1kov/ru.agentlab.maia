package ru.agentlab.maia.internal.protocol

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.protocol.IProtocol
import ru.agentlab.maia.protocol.IProtocolRole

@Accessors
abstract class Protocol implements IProtocol {

	String name

	val List<IProtocolRole> roles = new ArrayList<IProtocolRole>

}