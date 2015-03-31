package ru.agentlab.maia.behaviour

/**
 * Mapping [<code>IActionState</code> -> <code>Contributor</code>]. Intended for
 * reusing <code>IActionScheme</code> between behaviours.
 */
interface IActionMapping {

	def Object get(IActionState state)

}