package ru.agentlab.maia.container

import java.net.URI

interface IContainerId {

	/**
	 *   Read the name of a location.
	 *   @return A name for this location. The name has only a local meaning.
	 */
	def String getName()

	/**
	 *   Read the address for a location.
	 *   @return The transport address of this location (in the specified protocol).
	 */
	def URI getAddress()


	
}