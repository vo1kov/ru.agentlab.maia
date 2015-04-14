package ru.agentlab.maia.execution.scheduler.bounded

import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.IMaiaContextScheduler

interface IMaiaBoundedContextScheduler extends IMaiaContextScheduler {

	def void add(IMaiaContext context, String state)

}