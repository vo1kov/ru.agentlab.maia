package ru.agentlab.maia.execution.scheduler.bounded

import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorScheduler

interface IMaiaBoundedExecutorScheduler extends IMaiaExecutorScheduler {

	def void link(IMaiaExecutorNode context, String state)

}