package org.maia.internal.initializer

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.annotations.Optional
import org.maia.initializer.IInitializerService
import org.slf4j.LoggerFactory

class InitializerService implements IInitializerService {

	val static LOGGER = LoggerFactory.getLogger(InitializerService)

	@Inject @Optional
	IEclipseContext context

	@PostConstruct
	def void init() {
		context.declareModifiable(IInitializerService.KEY_INITIALIZER)
	}

	override addInitializer(Class<?> contributorClass) {
		if (context == null) {
			throw new IllegalArgumentException(
				"Unknown context, use [createMessageQueue(IEclipseContext ctx)] method instead")
		}
		return context.addInitializer(contributorClass)
	}

	override addInitializer(IEclipseContext ctx, Class<?> contributorClass) {
		LOGGER.info("Create Contributor...")
		if (contributorClass == null) {
			throw new NullPointerException("Contributor class is null")
		}
		val contributor = ContextInjectionFactory.make(contributorClass, ctx)
		LOGGER.debug("	Put [{}]->[{}] to [{}] context...", IInitializerService.KEY_INITIALIZER, contributor, ctx)
		ctx.modify(IInitializerService.KEY_INITIALIZER, contributor)
		ContextInjectionFactory.invoke(contributor, PostConstruct, ctx, null)
		return contributor
	}

}