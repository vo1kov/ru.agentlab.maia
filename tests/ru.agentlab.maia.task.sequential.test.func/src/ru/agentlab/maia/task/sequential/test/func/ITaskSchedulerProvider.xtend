package ru.agentlab.maia.task.sequential.test.func

import ru.agentlab.maia.task.ITaskScheduler

interface ITaskSchedulerProvider {

	def ITaskScheduler get()
}