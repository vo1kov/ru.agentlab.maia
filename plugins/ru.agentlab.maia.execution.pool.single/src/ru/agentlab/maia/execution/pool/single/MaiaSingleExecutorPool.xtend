package ru.agentlab.maia.execution.pool.single

import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool

class MaiaSingleExecutorPool implements IMaiaExecutorPool {

	ExecutorService exe = Executors.newSingleThreadScheduledExecutor

	override submit(Runnable r) {
		return exe.submit(r)
	}

	override isFixedSize() {
		return true
	}
}