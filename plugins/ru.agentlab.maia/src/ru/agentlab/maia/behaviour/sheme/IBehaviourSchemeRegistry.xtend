package ru.agentlab.maia.behaviour.sheme

import java.util.Collection

interface IBehaviourSchemeRegistry {

	def IBehaviourScheme getDefaultScheme()

	def Collection<IBehaviourScheme> getSchemes()

}