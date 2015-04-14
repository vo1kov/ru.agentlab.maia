package ru.agentlab.maia.execution.scheduler.bounded

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

interface IMaiaBoundedContextScheduler extends IMaiaExecutorScheduler {

	def void add(IMaiaContext context, String state)

}