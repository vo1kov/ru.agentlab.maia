package ru.agentlab.maia.behaviour

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

	def void setBehaviour(Behaviour behaviour)

	def Behaviour getBehaviour()

}