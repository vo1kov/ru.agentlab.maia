package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

class MaiaExecutorService implements IMaiaExecutorService {

	@Inject
	ExecutorService executor

	@Inject
	IExecutionNode node

	var isActive = new AtomicBoolean(false)

	override void start() {
		isActive.set(true)
		executor.submit(new Runnable {
			override run() {
				if (isActive.get) {
					println("===========begin============")
					val begin = System.nanoTime
					node.run
					val end = System.nanoTime
					println("	" + (end - begin) + " ns")
					println("============end=============")
					executor.submit(this)
				}
			}
		})
	}

	override void stop() {
		isActive.set(false)
	}

}