package ru.agentlab.maia.behaviour

import org.eclipse.xtend.lib.annotations.Accessors

class BehaviourException implements IBehaviourException {

	@Accessors
	var String name

	new(String name) {
		this.name = name
	}

}