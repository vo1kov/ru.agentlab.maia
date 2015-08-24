package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import java.util.concurrent.Callable

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
		executor.submit(callable)
	}
	
	def Callable<Object> getCallable(){
		return new Callable<Object> {

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

			override call() throws Exception {
				try {
					if (isActive.get) {
						val result = root.runAction
						executor.submit(this)
						return result
					}
				} catch (Exception e) {
					return e
				}
			}

		}
	}

	override void stop() {
		isActive.set(false)
	}

}