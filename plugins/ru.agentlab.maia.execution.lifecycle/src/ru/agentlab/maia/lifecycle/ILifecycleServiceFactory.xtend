package ru.agentlab.maia.lifecycle

import ru.agentlab.maia.context.IMaiaContext

interface ILifecycleServiceFactory {

	def ILifecycleService createLifecycle(IMaiaContext context)

}