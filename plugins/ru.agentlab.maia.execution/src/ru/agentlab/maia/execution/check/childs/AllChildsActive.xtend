package ru.agentlab.maia.execution.check.childs

import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.check.IChildsCheck

class AllChildsActive implements IChildsCheck {

	override test(Iterable<IExecutionNode> childs) {
		return childs.findFirst[state != ExecutionNodeState.ACTIVE] == null
	}

}