package ru.agentlab.maia.execution.scheduler.sequential.test.func

import ru.agentlab.maia.execution.ITaskScheduler

interface ITaskSchedulerProvider {

	def ITaskScheduler get()
}