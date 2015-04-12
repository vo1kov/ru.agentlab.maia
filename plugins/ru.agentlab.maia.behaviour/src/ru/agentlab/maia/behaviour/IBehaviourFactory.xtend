package ru.agentlab.maia.behaviour

import ru.agentlab.maia.IMaiaContext

interface IBehaviourFactory {
	
	def IMaiaContext createBehaviour()
	
}