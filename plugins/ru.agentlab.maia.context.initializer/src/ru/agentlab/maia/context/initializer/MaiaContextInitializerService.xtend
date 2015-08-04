package ru.agentlab.maia.context.initializer

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector

class MaiaContextInitializerService implements IMaiaContextInitializerService {

	@Inject
	IMaiaContext context

	override <T> addInitializer(Class<T> contributorClass) {
		if (contributorClass == null) {
			throw new NullPointerException("Contributor class is null")
		}
		val injector = context.get(IMaiaContextInjector)
		val initializer = injector.make(contributorClass, context)
		context.set(IMaiaContextInitializerService.KEY_INITIALIZER, initializer)
		injector.invoke(initializer, PostConstruct, context, null)
		return initializer
	}

}