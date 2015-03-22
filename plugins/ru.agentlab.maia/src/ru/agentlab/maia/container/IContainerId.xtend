package ru.agentlab.maia.container

import java.util.List
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.platform.IPlatformId

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
	def String getAddress()

	def IPlatformId getPlatformId()
	
	def List<IAgentId> getAgentIds()

	def void setPlatformId(IPlatformId platformId)

}