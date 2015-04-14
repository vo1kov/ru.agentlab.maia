package ru.agentlab.maia.e4

import java.lang.annotation.Annotation
import javax.inject.Inject
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextListener
import ru.agentlab.maia.event.IEventBroker
import ru.agentlab.maia.injector.IMaiaContextInjector

class E4MaiaContextInjector implements IMaiaContextInjector {
	
	@Inject
	IEventBroker broker
	
	override <T> make(Class<T> contributorClass, IMaiaContext context) {
		val result = ContextInjectionFactory.make(contributorClass, context.get(IEclipseContext))
		broker.post(EVENT_INJECTOR_MAKE, result)
		return result
	}
	
	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext))
		broker.post(EVENT_INJECTOR_INVOKE, result)
		return result
	}
	
	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext), defaultValue)
		broker.post(EVENT_INJECTOR_INVOKE, result)
		return result
	}

	override inject(Object service, IMaiaContext context) {
		ContextInjectionFactory.inject(service, context.get(IEclipseContext))
		broker.post(EVENT_INJECTOR_INJECT, service)
	}

	override addListener(IMaiaContext context, String key, IMaiaContextListener listener) {
		context.get(IEclipseContext).runAndTrack [
			get(key)
			val result = listener.onChange(get(IMaiaContext))
			return result
		]
	}

	override addListener(IMaiaContext context, Class<?> key, IMaiaContextListener listener) {
		context.get(IEclipseContext).runAndTrack [
			get(key)
			val result = listener.onChange(get(IMaiaContext))
			return result
		]
	}

}