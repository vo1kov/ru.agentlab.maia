package ru.agentlab.maia.platform.internal

import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.platform.IPlatformLifecycleService
import ru.agentlab.maia.IPlatform

class PlatformLifecycleService implements IPlatformLifecycleService {

	@Inject
	IEclipseContext context

	override void startPlatform(String id) {
		val platformContext = context.createChild("Platform [" + id + "] Context") => [
			set(IPlatform.KEY_NAME, id)
		]
	}

}