package ru.agentlab.maia.behaviour

/**
 * Mapping [<code>IActionState</code> -> <code>Contributor</code>]. Intended for
 * reusing <code>IActionScheme</code> between behaviours.
 */
interface IBehaviourTaskMapping {

	def Object get(IBehaviourState state)
	
	def void put(IBehaviourState state, Object task)

}