package ru.agentlab.maia.internal.platform

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.platform.IPlatform
import ru.agentlab.maia.platform.IPlatformFactory

class PlatformFactory implements IPlatformFactory {

	@Inject
	IEclipseContext context

	override create(String id, Class<?> contributorClass) {

		// Prepare Platform Context
		val platformContext = context.createChild("Platform [" + id + "] Context") => [
			set(IPlatform.KEY_NAME, id)
		]

		// Create Platform instance in Context
		val platform = ContextInjectionFactory.make(Platform, platformContext)
		ContextInjectionFactory.invoke(platform, PostConstruct, platformContext, null)
		platformContext.set(IPlatform, platform)

		// Create Platform Contributor in Context
		val contributor = ContextInjectionFactory.make(contributorClass, platformContext)
		ContextInjectionFactory.invoke(contributor, PostConstruct, platformContext, null)
		platformContext.set(IPlatform.KEY_CONTRIBUTOR, contributor)

		return platform
	}

}