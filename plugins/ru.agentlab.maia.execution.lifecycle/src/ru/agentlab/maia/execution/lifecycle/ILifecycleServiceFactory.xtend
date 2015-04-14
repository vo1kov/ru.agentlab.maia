package ru.agentlab.maia.execution.lifecycle

import ru.agentlab.maia.context.IMaiaContext

interface ILifecycleServiceFactory {

	def ILifecycleService createLifecycle(IMaiaContext context)

}