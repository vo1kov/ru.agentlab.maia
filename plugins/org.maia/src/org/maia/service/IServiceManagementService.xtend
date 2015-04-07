package org.maia.service

import org.eclipse.e4.core.contexts.IEclipseContext

/**
 * <p>Service for manage services in contexts.</p> 
 * <p>Service provide means for manage Service lifecycle: Copy, Move, Add, 
 * Remove services from context.</p>
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IServiceManagementService {

	/**
	 * Copy Service from another context.
	 * 
	 * @param fromContext - context that have interest service.
	 * @param toContext - target context in which the service is to be copied.
	 * @param serviceClass - class of interest service
	 * @param <T> - type of service
	 * @throws IllegalStateException when <code>fromContext</code> have no service to copy.
	 */
	def <T> T copyService(IEclipseContext fromContext, IEclipseContext toContext, Class<T> serviceClass) 
		throws IllegalStateException
		
	def Object copyService(IEclipseContext fromContext, IEclipseContext toContext, String serviceName) 
		throws IllegalStateException

	/**
	 * Move Service from another context.
	 * 
	 * @param fromContext - context that have interest service.
	 * @param toContext - target context in which the service is to be moved.
	 * @param serviceClass - class of interest service
	 * @param <T> - type of service
	 * @throws IllegalStateException when <code>fromContext</code> have no service to move.
	 */
	def <T> void moveService(IEclipseContext fromContext, IEclipseContext toContext, Class<T> serviceClass) 
		throws IllegalStateException
		
	def void moveService(IEclipseContext fromContext, IEclipseContext toContext, String serviceName) 
		throws IllegalStateException

	/**
	 * Add Service to context.
	 * 
	 * @param context - context in which the service is to be added.
	 * @param service - service object.
	 */
	def <T> void addService(IEclipseContext context, Class<T> serviceClass, T service)
	
	def void addService(IEclipseContext context, String serviceName, Object service)

	def <T> T createService(IEclipseContext context, Class<T> serviceClass)
	
	/**
	 * Remove Service to context.
	 * 
	 * @param context - context in which the service is to be removed.
	 * @param serviceClass - service class to be removed.
	 */
	def <T> void removeService(IEclipseContext context, Class<T> serviceClass)
	
	def void removeService(IEclipseContext context, String serviceName)

}