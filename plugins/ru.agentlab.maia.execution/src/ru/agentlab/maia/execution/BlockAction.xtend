package ru.agentlab.maia.execution

class BlockAction extends AbstractExecutionNode implements IExecutionAction {

	override run() {
		state = IExecutionNode.State.BLOCKED
		parent.get?.notifyChildBlocked
	}

}