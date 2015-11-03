package ru.agentlab.maia.task

interface ITaskRegistry {

	def void put(String uuid, ITask task)

	def ITask get(String uuid)

}
