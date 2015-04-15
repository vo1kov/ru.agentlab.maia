package ru.agentlab.maia.execution.pool.cached

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool

class MaiaCachedExecutorPool implements IMaiaExecutorPool {

	ExecutorService exe = Executors.newCachedThreadPool

	override submit(Runnable r) {
		return exe.submit(r)
	}
	
	override isFixedSize() {
		return false
	}

}