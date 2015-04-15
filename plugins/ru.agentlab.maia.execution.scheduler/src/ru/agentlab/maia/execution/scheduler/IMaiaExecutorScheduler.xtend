package ru.agentlab.maia.execution.scheduler

import ru.agentlab.maia.execution.node.IMaiaExecutorNode

interface IMaiaExecutorScheduler extends IMaiaExecutorNode {

	val static public String KEY_CURRENT_CONTEXT = "ru.agentlab.maia.execution.scheduler|current.context"

	def IMaiaExecutorNode getCurrentContext()

	def IMaiaExecutorNode getNextContext()

	def void remove(IMaiaExecutorNode context)

	def void removeAll()

	def boolean isEmpty()

}