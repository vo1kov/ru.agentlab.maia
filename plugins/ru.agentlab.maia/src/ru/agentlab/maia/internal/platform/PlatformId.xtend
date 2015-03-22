package ru.agentlab.maia.internal.platform

import java.net.URI
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.platform.IPlatformId

class PlatformId implements IPlatformId {

	@Accessors
	var String name

	@Accessors
	var URI address

}