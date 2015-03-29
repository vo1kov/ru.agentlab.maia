package ru.agentlab.maia.platform

import java.net.URI
import java.util.List
import ru.agentlab.maia.container.IContainerId

/**
 * Interface for Platform ID.
 * 
 * @author <a href='shishkin_dimon@gmail.com'>Shishkin Dmitriy</a> - Initial contribution.
 */
interface IPlatformId {

	/**
	 * Read the name of a location.
	 * @return A name for this location. The name has only a local meaning.
	 */
	def String getName()

	/**
	 * Read the address for a location.
	 * @return The transport address of this location (in the specified protocol).
	 */
	def URI getAddress()

	def List<IContainerId> getContainerIds()

}