package ru.agentlab.maia.execution.check

import ru.agentlab.maia.execution.tree.IExecutionNode

interface IChildsCheck extends ICheck {

	def boolean test(Iterable<IExecutionNode> childs)

}