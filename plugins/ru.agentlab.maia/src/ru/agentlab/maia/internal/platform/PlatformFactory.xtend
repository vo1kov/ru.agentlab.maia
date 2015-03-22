package ru.agentlab.maia.internal.platform

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.slf4j.LoggerFactory
import ru.agentlab.maia.platform.IPlatform
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.platform.IPlatformIdFactory

class PlatformFactory implements IPlatformFactory {

	val static LOGGER = LoggerFactory.getLogger(PlatformFactory)

	@Inject
	IPlatformIdFactory platformIdFactory

	override create(String id, Class<?> contributorClass) {

		LOGGER.info("Prepare Platform Context...")
		val platformContext = EclipseContextFactory.create("Platform [" + id + "] Context") => [
			set(IPlatform.KEY_NAME, id)
		]
		
		LOGGER.info("Prepare Platform Instance in Context...")
		val platform = ContextInjectionFactory.make(Platform, platformContext)
		ContextInjectionFactory.invoke(platform, PostConstruct, platformContext, null)
		platformContext.set(IPlatform, platform)

		LOGGER.info("Prepare PlatformID in Context...")
		val platformId = platformIdFactory.create(id)
		platformContext.set(IPlatformId, platformId)
		platform.platformId = platformId

		LOGGER.info("Prepare Platform Contributor in Context...")
		if (contributorClass != null) {
			val contributor = ContextInjectionFactory.make(contributorClass, platformContext)
			platformContext.set(IPlatform.KEY_CONTRIBUTOR, contributor)
			ContextInjectionFactory.invoke(contributor, PostConstruct, platformContext, null)
		}

		return platform
	}

}