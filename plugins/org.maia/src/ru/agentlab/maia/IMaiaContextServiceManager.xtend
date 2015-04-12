package ru.agentlab.maia

interface IMaiaContextServiceManager {

	def <T> T getService(IMaiaContext context, Class<T> serviceClass)

	/**
	 * Copy Service from another context.
	 * 
	 * @param fromContext - context that have interest service.
	 * @param toContext - target context in which the service is to be copied.
	 * @param serviceClass - class of interest service
	 * @param <T> - type of service
	 * @throws IllegalStateException when <code>fromContext</code> have no service to copy.
	 */
	def <T> T copyService(IMaiaContext fromContext, IMaiaContext toContext, Class<T> serviceClass) 
		throws IllegalStateException

	def Object copyService(IMaiaContext fromContext, IMaiaContext toContext, String serviceName) 
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
	def <T> void moveService(IMaiaContext fromContext, IMaiaContext toContext, Class<T> serviceClass) 
		throws IllegalStateException

	def void moveService(IMaiaContext fromContext, IMaiaContext toContext, String serviceName) 
		throws IllegalStateException

	/**
	 * Add Service to context.
	 * 
	 * @param context - context in which the service is to be added.
	 * @param service - service object.
	 */
	def <T> void addService(IMaiaContext context, Class<T> serviceClass, T service)

	def void addService(IMaiaContext context, String serviceName, Object service)

	def <T> T createService(IMaiaContext context, Class<T> serviceClass)

	/**
	 * Remove Service to context.
	 * 
	 * @param context - context in which the service is to be removed.
	 * @param serviceClass - service class to be removed.
	 */
	def <T> void removeService(IMaiaContext context, Class<T> serviceClass)

	def void removeService(IMaiaContext context, String serviceName)

}