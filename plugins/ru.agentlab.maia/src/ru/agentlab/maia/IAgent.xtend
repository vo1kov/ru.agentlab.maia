package ru.agentlab.maia

import java.util.UUID

/**
 * 
 * @author Dmitry Shishkin
 */
interface IAgent {

	def UUID getUuid()

	def void start()

	def void stop()

	def boolean isActive()

	def void setBehaviour(IBehaviour behaviour)

	def IBehaviour getBehaviour()
	
	def IContainer getContainer()

	/**
	 * 
	 * @author Dmitry Shishkin
	 */
	static enum State {

		UNKNOWN,

		WAITING,

		ACTIVE,

		SUSPENDED,

		TRANSIT,

		INITIATED

	}
}
