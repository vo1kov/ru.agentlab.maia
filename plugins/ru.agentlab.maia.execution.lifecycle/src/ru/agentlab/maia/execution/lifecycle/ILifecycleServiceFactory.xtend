package ru.agentlab.maia.execution.lifecycle

import ru.agentlab.maia.context.IMaiaContext

interface ILifecycleServiceFactory {

	def IMaiaContextLifecycleService createLifecycle(IMaiaContext context)

}