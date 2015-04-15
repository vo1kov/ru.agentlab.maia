package ru.agentlab.maia.context.initializer

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.IMaiaContextInjector

class MaiaContextInitializerService implements IMaiaContextInitializerService {

	val static LOGGER = LoggerFactory.getLogger(MaiaContextInitializerService)

	@Inject
	IMaiaContext context

	override addInitializer(IMaiaContext ctx, Class<?> contributorClass) {
		val context = if (ctx != null) {
				ctx
			} else {
				this.context
			}
		LOGGER.info("Create Initializer...")
		if (contributorClass == null) {
			throw new NullPointerException("Contributor class is null")
		}
		val injector = context.get(IMaiaContextInjector)
		val initializer = injector.make(contributorClass, context)
		LOGGER.debug("	Put [{}]->[{}] to [{}] context...", IMaiaContextInitializerService.KEY_INITIALIZER,
			initializer, context)
		context.set(IMaiaContextInitializerService.KEY_INITIALIZER, initializer)
		injector.invoke(initializer, PostConstruct, context, null)
		return initializer
	}

}