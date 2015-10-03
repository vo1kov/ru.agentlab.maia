package ru.agentlab.maia.execution

class BlockAction extends AbstractExecutionNode implements IExecutionAction {

	override protected runInternal() {
		state = IExecutionNode.State.BLOCKED
		parent.get?.notifyChildBlocked
	}

}