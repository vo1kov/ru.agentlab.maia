package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import javax.annotation.PostConstruct
import javax.inject.Inject

class MaiaExecutorTask implements IMaiaExecutorTask {

	@Inject
	ExecutorService executor

	@Inject
	IMaiaExecutorNode node

	IMaiaExecutorRunnable runnable

	@PostConstruct
	def void init() {
		runnable = new MaiaExecutorRunnable(executor, node)
	}

	override void start() {
		executor.submit(runnable)
	}

}