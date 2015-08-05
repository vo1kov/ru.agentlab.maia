package ru.agentlab.maia.context.initializer

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector

class MaiaContextInitializerService implements IMaiaContextInitializerService {

	IMaiaContext context
	
	@Inject
	new(IMaiaContext context){
		this.context = context
	}

	override <T> initService(Class<T> contributorClass) {
		if (contributorClass == null) {
			throw new NullPointerException("Service class is null")
		}
		val injector = context.get(IMaiaContextInjector)
		val initializer = injector.make(contributorClass, context)
		context.set(initializer.class.name, initializer)
		injector.invoke(initializer, PostConstruct, context, null)
		return initializer
	}

}