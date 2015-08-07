package ru.agentlab.maia.context

import javax.annotation.PostConstruct
import ru.agentlab.maia.context.exception.MaiaDeploymentException
import ru.agentlab.maia.context.exception.MaiaInjectionException

/**
 * <p>Service for deploying services to context.</p>
 * 
 * <p><b>Required services:</b></p>
 * <ul>
 * <li>{@link IMaiaContextInjector}</li>
 * </ul>
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
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
		val injector = context.getLocal(IMaiaContextInjector)
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
		val injector = context.getLocal(IMaiaContextInjector)
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
		val injector = context.getLocal(IMaiaContextInjector)
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
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			val service = injector.make(serviceClass)
			injector.invoke(service, PostConstruct, null)
			context.set(interf, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override deploy(Object service, String key) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(key, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

	override <T> deploy(T service, Class<T> interf) throws MaiaDeploymentException {
		val injector = context.getLocal(IMaiaContextInjector)
		try {
			injector.inject(service)
			injector.invoke(service, PostConstruct, null)
			context.set(interf, service)
			return service
		} catch (MaiaInjectionException e) {
			throw new MaiaDeploymentException(e)
		}
	}

}