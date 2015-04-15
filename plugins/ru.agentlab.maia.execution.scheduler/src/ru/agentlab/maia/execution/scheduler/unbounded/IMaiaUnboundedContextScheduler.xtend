package ru.agentlab.maia.execution.scheduler.unbounded

import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

interface IMaiaUnboundedContextScheduler extends IMaiaExecutorScheduler {

	def void add(IMaiaExecutorNode context)

}