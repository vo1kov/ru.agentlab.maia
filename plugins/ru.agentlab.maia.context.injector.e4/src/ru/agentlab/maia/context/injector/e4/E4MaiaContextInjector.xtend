package ru.agentlab.maia.context.injector.e4

import java.lang.annotation.Annotation
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.injector.IMaiaContextInjector

class E4MaiaContextInjector implements IMaiaContextInjector {

	override <T> make(Class<T> contributorClass, IMaiaContext context) {
		val result = ContextInjectionFactory.make(contributorClass, context.get(IEclipseContext))
		return result
	}

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext))
		return result
	}

	override invoke(Object object, Class<? extends Annotation> ann, IMaiaContext context, Object defaultValue) {
		val result = ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext), defaultValue)
		return result
	}

	override inject(Object service, IMaiaContext context) {
		ContextInjectionFactory.inject(service, context.get(IEclipseContext))
	}

}