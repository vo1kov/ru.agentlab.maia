package ru.agentlab.maia

import org.osgi.framework.BundleContext

/**
 * <p>Factory for creating Contexts.</p>
 * <p>Contexts represent platform, container, agent and behaviour objects. Context 
 * can contain layer-specific services for injection.</p> 
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IMaiaContextFactory {

	/**
	 * Key for store context name
	 */
	val static String KEY_NAME = "context.name"

	/**
	 * Create Context with default set of services. Set of services depends of
	 * implementation
	 * @param root - parent context where platform will be created
	 * @param id - unique id of context. If <code>null</code>, then some implementation of 
	 * {@link INameGenerator INameGenerator} will be used for 
	 * generating context name.
	 * @return Context with default set of services
	 */
	def IMaiaContext createContext(String name)

	/**
	 * Create Context without any additional services
	 * @param root - parent context where platform will be created
	 * @param id - unique id of context. If <code>null</code>, then some implementation of 
	 * {@link INameGenerator INameGenerator} will be used for 
	 * generating context name.
	 * @return Context without any additional services
	 */
	def IMaiaContext createChild(IMaiaContext parent, String name)

	def IMaiaContext createOsgiContext(BundleContext bundleContext)

}