package org.maia.protocol.internal

import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.maia.protocol.IProtocol

@Accessors
class ProtocolRegistry {

	val protocols = new ArrayList<IProtocol>

}