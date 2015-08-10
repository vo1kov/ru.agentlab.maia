package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

class MaiaExecutorService implements IMaiaExecutorService {

	@Inject
	ExecutorService executor

	IMaiaExecutorNode root

	@Inject
	IMaiaContext context

	AtomicBoolean isActive = new AtomicBoolean(false)

	override void start() {
		root = if (context.getLocal(IMaiaExecutorAction) != null) {
			context.getLocal(IMaiaExecutorAction)
		} else {
			context.getLocal(IMaiaExecutorScheduler)
		}
		isActive.set(true)
		val runnable = new Runnable {

			override run() {
				try {
					if (isActive.get) {
						root.runAction
						executor.submit(this)
					}
				} catch (Exception e) {
				}
			}

			def private Object runAction(IMaiaExecutorNode node) {
				switch (node) {
					IMaiaExecutorAction: {
						return node.run
					}
					IMaiaExecutorScheduler: {
						return runAction(node.nextNode)
					}
					default: {
						throw new IllegalStateException
					}
				}
			}
		}
		executor.submit(runnable)
	}

	override void stop() {
		isActive.set(false)
	}

}