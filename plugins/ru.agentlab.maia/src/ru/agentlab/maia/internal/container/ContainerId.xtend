package ru.agentlab.maia.internal.container

import java.net.URI
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.container.IContainerId

class ContainerId implements IContainerId {

	@Accessors
	var String name

	@Accessors
	var URI address

}