package ru.agentlab.maia.execution.scheduler

interface IMaiaContextSchedulerFactory {

	def IMaiaExecutorScheduler createScheduler()

}