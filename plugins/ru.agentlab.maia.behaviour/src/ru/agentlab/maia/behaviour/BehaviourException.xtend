package ru.agentlab.maia.behaviour

import org.eclipse.xtend.lib.annotations.Accessors

/**
 * 
 * @author Dmitry Shishkin
 */
class BehaviourException<T> {

	@Accessors
	val protected Class<T> type

	new(Class<T> type) {
		this.type = type
	}

}