package ru.agentlab.maia.lifecycle

import ru.agentlab.maia.IMaiaContext

interface ILifecycleServiceFactory {

	def ILifecycleService createLifecycle(IMaiaContext context)

}