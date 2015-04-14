package ru.agentlab.maia.context.injector.e4

import java.lang.annotation.Annotation
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.IMaiaContextInjector
import ru.agentlab.maia.context.injector.event.MaiaContextInjectorInjectEvent
import ru.agentlab.maia.context.injector.event.MaiaContextInjectorInvokeEvent
import ru.agentlab.maia.context.injector.event.MaiaContextInjectorMakeEvent
import ru.agentlab.maia.event.IMaiaEventBroker

class E4MaiaContextInjector implements IMaiaContextInjector {

	var IMaiaEventBroker broker

	@Inject
	new(IMaiaEventBroker broker) {
		this.broker = broker
	}

	override <T> make(Class<T> contributorClass, IMaiaContext context) {
		val result = ContextInjectionFactory.make(contributorClass, context.get(IEclipseContext))
		broker.post(new MaiaContextInjectorMakeEvent(contributorClass, result))
		return result
	}

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext))
		broker.post(new MaiaContextInjectorInvokeEvent(object, ann))
		return result
	}

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext), defaultValue)
		broker.post(new MaiaContextInjectorInvokeEvent(object, ann))
		return result
	}

	override inject(Object service, IMaiaContext context) {
		ContextInjectionFactory.inject(service, context.get(IEclipseContext))
		broker.post(new MaiaContextInjectorInjectEvent(service))
	}

}