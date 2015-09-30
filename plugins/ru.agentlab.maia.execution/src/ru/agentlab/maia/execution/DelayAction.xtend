package ru.agentlab.maia.execution

class DelayAction extends AbstractExecutionAction {

	override run() {
		state = IExecutionNode.BLOCKED
		parent.get.notifyChildBlocked
	}

	override doInject() {
		// Do nothing
	}

	override doUninject() {
		// Do nothing
	}

	override doRun() {
		// Do nothing
	}

	override reset() {
		// Do nothing
	}

}