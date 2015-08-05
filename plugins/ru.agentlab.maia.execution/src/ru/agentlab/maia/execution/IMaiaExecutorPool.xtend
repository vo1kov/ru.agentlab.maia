package ru.agentlab.maia.execution

import java.util.concurrent.Future

interface IMaiaExecutorPool {

	def Future<?> submit(Runnable r)
	
	def boolean isFixedSize()

}