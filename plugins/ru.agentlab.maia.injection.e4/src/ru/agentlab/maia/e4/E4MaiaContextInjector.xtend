package ru.agentlab.maia.e4

import java.lang.annotation.Annotation
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextListener
import ru.agentlab.maia.injector.IMaiaContextInjector

class E4MaiaContextInjector implements IMaiaContextInjector {

	override <T> make(Class<T> contributorClass, IMaiaContext context) {
		return ContextInjectionFactory.make(contributorClass, context.get(IEclipseContext))
	}

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue) {
		return ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext), defaultValue)
	}

	override inject(Object service, IMaiaContext context) {
		ContextInjectionFactory.inject(service, context.get(IEclipseContext))
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

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context) {
		return ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext))
	}

}