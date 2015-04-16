package ru.agentlab.maia.execution.scheduler.bounded

import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

interface IMaiaBoundedContextScheduler extends IMaiaExecutorScheduler {

	def void link(IMaiaExecutorNode context, String state)

}