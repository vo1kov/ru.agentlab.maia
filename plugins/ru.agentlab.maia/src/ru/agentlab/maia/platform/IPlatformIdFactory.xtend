package ru.agentlab.maia.platform

/**
 * Factory Service for creating Platform Ids.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IPlatformIdFactory {
	
	/**
	 * Create new instance of Platform ID
	 * 
	 * @param name - name of platform id to be created
	 * @return new Platform ID instance with given name
	 */
	def IPlatformId create(String name)
	
}