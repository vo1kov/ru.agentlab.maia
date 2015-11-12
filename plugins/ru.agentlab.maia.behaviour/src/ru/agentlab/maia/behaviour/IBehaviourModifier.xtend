package ru.agentlab.maia.behaviour

import java.util.Map

interface IBehaviourModifier {

	val static final String KEY_TYPE = "type"

	def void modify(IBehaviour task, Map<String, ?> input)

}