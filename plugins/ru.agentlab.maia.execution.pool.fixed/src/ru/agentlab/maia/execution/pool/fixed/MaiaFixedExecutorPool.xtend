package ru.agentlab.maia.execution.pool.fixed

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import ru.agentlab.maia.execution.IMaiaExecutorPool

class MaiaFixedExecutorPool implements IMaiaExecutorPool {

	ExecutorService exe = Executors.newFixedThreadPool(2)

	override submit(Runnable r) {
		return exe.submit(r)
	}

	override isFixedSize() {
		return true
	}
}