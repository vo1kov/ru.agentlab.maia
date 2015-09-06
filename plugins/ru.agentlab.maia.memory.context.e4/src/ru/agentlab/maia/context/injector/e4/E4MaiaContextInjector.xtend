package ru.agentlab.maia.context.injector.e4

import java.lang.annotation.Annotation
import org.eclipse.e4.core.contexts.ContextInjectionFactory
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.di.InjectionException
import ru.agentlab.maia.memory.IMaiaContext
import ru.agentlab.maia.memory.IMaiaContextInjector
import ru.agentlab.maia.memory.exception.MaiaInjectionException
import ru.agentlab.maia.memory.exception.MaiaDeploymentException

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
	
	override <T> deploy(Class<T> serviceClass) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> deploy(Class<T> serviceClass, String key) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> deploy(Class<? extends T> serviceClass, Class<T> serviceInterface) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override deploy(Object service) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override deploy(Object service, String key) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override <T> deploy(T service, Class<T> interf) throws MaiaDeploymentException {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

}