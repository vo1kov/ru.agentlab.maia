package ru.agentlab.maia.internal.platform

import java.net.URI
import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.container.IContainerId
import ru.agentlab.maia.platform.IPlatformId

@Accessors
class PlatformId implements IPlatformId {

	var String name

	var URI address

	val List<IContainerId> containerIds = new ArrayList<IContainerId>

}