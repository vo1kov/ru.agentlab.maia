package org.maia.protocol.internal

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.protocol.IProtocol
import org.maia.protocol.IProtocolRole

@Accessors
abstract class Protocol implements IProtocol {

	String name

	val List<IProtocolRole> roles = new ArrayList<IProtocolRole>

}