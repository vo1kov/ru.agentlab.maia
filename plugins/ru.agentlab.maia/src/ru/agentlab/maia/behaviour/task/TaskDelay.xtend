package ru.agentlab.maia.behaviour.task

import javax.inject.Inject
import ru.agentlab.maia.Action

class TaskDelay {

	long period
	
	String key

	@Inject
	new(String key, long period) {
		this.period = period
		this.key = key
	}

	@Action
	def void action() {
	}

}