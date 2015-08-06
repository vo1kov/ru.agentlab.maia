package ru.agentlab.maia.context

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.exception.MaiaInjectionException
import ru.agentlab.maia.context.exception.MaiaDeploymentException

class MaiaServiceDeployer implements IMaiaServiceDeployer {

	IMaiaContext context

	new(IMaiaContext context) {
		this.context = context
	}

	/**
	 * PostConstruct method is invoked before registration service in context.
	 * Services can remove old services from context in PostConstruct method.
	 */
	override <T> deploy(Class<T> serviceClass) throws MaiaDeploymentException {
		val injector = context.get(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(serviceClass, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override deploy(Object service) throws MaiaDeploymentException {
		val injector = context.get(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(service.class.name, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}
	
	override <T> deploy(Class<T> serviceClass, String key) throws MaiaDeploymentException {
		val injector = context.get(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(key, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}
	
	override <T> deploy(Class<? extends T> serviceClass, Class<T> interf) throws MaiaDeploymentException {
		val injector = context.get(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(interf, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

}