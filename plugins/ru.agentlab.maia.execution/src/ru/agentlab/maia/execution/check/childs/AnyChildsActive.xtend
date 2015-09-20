package ru.agentlab.maia.execution.check.childs

import ru.agentlab.maia.execution.check.IChildsCheck
import ru.agentlab.maia.execution.tree.IExecutionNode

class AnyChildsActive implements IChildsCheck {

	override test(Iterable<IExecutionNode> childs) {
		return childs.findFirst[state == IExecutionNode.IN_WORK] != null
	}

}