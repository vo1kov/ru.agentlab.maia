package ru.agentlab.maia.context.injector.e4

import java.lang.annotation.Annotation
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.InjectionException
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.IMaiaContextInjector
import ru.agentlab.maia.context.exception.MaiaInjectionException

class E4MaiaContextInjector implements IMaiaContextInjector {

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	override <T> make(Class<T> contributorClass) throws MaiaInjectionException {
		return ContextInjectionFactory.make(contributorClass, context.get(IEclipseContext))
	}

	override invoke(Object object, Class<? extends Annotation> ann) throws MaiaInjectionException {
		try {
			return ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext))
		} catch (InjectionException e) {
			throw new MaiaInjectionException(e)
		}
	}

	override invoke(Object object, Class<? extends Annotation> ann, Object defaultValue) throws MaiaInjectionException {
		try {
			return ContextInjectionFactory.invoke(object, ann, context.get(IEclipseContext), defaultValue)
		} catch (InjectionException e) {
			throw new MaiaInjectionException(e)
		}
	}

	override inject(Object service) throws MaiaInjectionException {
		try {
			ContextInjectionFactory.inject(service, context.get(IEclipseContext))
		} catch (InjectionException e) {
			throw new MaiaInjectionException(e)
		}
	}

}