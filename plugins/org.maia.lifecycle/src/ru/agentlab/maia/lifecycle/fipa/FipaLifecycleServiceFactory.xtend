package ru.agentlab.maia.lifecycle.fipa

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.injector.IMaiaContextInjector
import ru.agentlab.maia.lifecycle.ILifecycleService
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.lifecycle.ILifecycleScheme

class FipaLifecycleServiceFactory implements ILifecycleServiceFactory {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaContextInjector injector

	override createLifecycle(IMaiaContext ctx) {
		val context = if (ctx != null) {
				ctx
			} else {
				this.context
			}

		context.set(ILifecycleScheme, new FipaLifecycleScheme)
		
		val lifecycleService = injector.make(LifecycleService, context)
		injector.invoke(lifecycleService, PostConstruct, context, null)
		context.set(ILifecycleService, lifecycleService)
		return lifecycleService
	}

}