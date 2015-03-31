package ru.agentlab.maia.internal.lifecycle.fipa

import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.lifecycle.ILifecycleServiceFactory
import ru.agentlab.maia.lifecycle.fipa.IFipaLifecycleService

class FipaLifecycleServiceFactory implements ILifecycleServiceFactory {

	@Inject
	IEclipseContext context

	override create() {
		val service = ContextInjectionFactory.make(FipaLifecycleService, context)
		ContextInjectionFactory.invoke(service, PostConstruct, null)
		context.set(IFipaLifecycleService, service)
		return service
	}

}