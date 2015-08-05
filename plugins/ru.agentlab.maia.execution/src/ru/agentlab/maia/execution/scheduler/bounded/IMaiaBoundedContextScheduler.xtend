package ru.agentlab.maia.execution.scheduler.bounded

import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

interface IMaiaBoundedContextScheduler extends IMaiaExecutorScheduler {

	def void link(IMaiaExecutorNode context, String state)

}