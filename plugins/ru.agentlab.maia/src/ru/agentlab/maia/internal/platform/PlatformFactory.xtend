package ru.agentlab.maia.internal.platform

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.EclipseContextFactory
import org.slf4j.LoggerFactory
import ru.agentlab.maia.internal.messaging.NettyMessageTransportServiceFactory
import ru.agentlab.maia.messaging.IMessageTransportService
import ru.agentlab.maia.platform.IPlatform
import ru.agentlab.maia.platform.IPlatformFactory
import ru.agentlab.maia.platform.IPlatformId
import ru.agentlab.maia.platform.IPlatformIdFactory
import ru.agentlab.maia.messaging.IMessageFactory
import ru.agentlab.maia.platform.IPlatformNameGenerator

class PlatformFactory implements IPlatformFactory {

	val static LOGGER = LoggerFactory.getLogger(PlatformFactory)

	@Inject
	IPlatformIdFactory platformIdFactory

	@Inject
	IMessageFactory messageFactory

	@Inject
	IPlatformNameGenerator nameGenerator

	override create(String id, Class<?> contributorClass) {
		LOGGER.info("Try to create new Platform...")
		LOGGER.debug("	Platform Id: [{}]", id)
		LOGGER.debug("	Platform contributorClass: [{}]", contributorClass)

		val name = if (id != null) {
				id
			} else {
				LOGGER.info("Generate Platform Name...")
				val n = nameGenerator.generate
				LOGGER.debug("	Platform Name is [{}]", n)
				n
			}

		LOGGER.info("Create Platform Context...")
		val platformContext = EclipseContextFactory.create("Platform [" + name + "] Context") => [
			LOGGER.debug("	Put [{}] Property to context...", IPlatform.KEY_NAME)
			set(IPlatform.KEY_NAME, name)
		]

		LOGGER.info("Create Platform-specific Services...")
		LOGGER.debug("	Put [{}] Service to context...", IMessageFactory.simpleName)
		platformContext.set(IMessageFactory, messageFactory)
		LOGGER.debug("	Put [{}] Service to context...", IMessageTransportService.simpleName)
		val mtsFactory = ContextInjectionFactory.make(NettyMessageTransportServiceFactory, platformContext)
		ContextInjectionFactory.invoke(mtsFactory, PostConstruct, platformContext, null)
		val mts = mtsFactory.create
//		ContextInjectionFactory.invoke(mts, PostConstruct, platformContext, null)
		platformContext.set(IMessageTransportService, mts)

		LOGGER.info("Create Platform ID...")
		val platformId = platformIdFactory.create(name)
		LOGGER.debug("	Put [{}] to context...", platformId)
		platformContext.set(IPlatformId, platformId)

		LOGGER.info("Create Platform Instance...")
		val platform = ContextInjectionFactory.make(Platform, platformContext)
		ContextInjectionFactory.invoke(platform, PostConstruct, platformContext, null)
		LOGGER.debug("	Put [{}] to context...", platform)
		platformContext.set(IPlatform, platform)

		if (contributorClass != null) {
			LOGGER.info("Create Platform Contributor...")
			val contributor = ContextInjectionFactory.make(contributorClass, platformContext)
			LOGGER.debug("	Put [{}] to context...", contributor)
			platformContext.set(IPlatform.KEY_CONTRIBUTOR, contributor)
			ContextInjectionFactory.invoke(contributor, PostConstruct, platformContext, null)
		}

		LOGGER.info("Platform successfully created!")
		LOGGER.debug("	Platform Id: [{}]", platform.id)
		LOGGER.debug("	Platform Childs: [{}]", platform.childs)
		LOGGER.debug("	Platform Context: [{}]", platform.context)
		return platform
	}

}