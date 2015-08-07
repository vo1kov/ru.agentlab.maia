package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext

class MaiaExecutorTask implements IMaiaExecutorTask {

	@Inject
	ExecutorService executor

	IMaiaExecutorRunnable runnable
	
	IMaiaExecutorNode root

	@Inject
	IMaiaContext context

	override void start() {
		root = if (context.getLocal(IMaiaExecutorAction) != null) {
				context.getLocal(IMaiaExecutorAction)
			} else {
				context.getLocal(IMaiaExecutorScheduler)
			}
		runnable = new MaiaExecutorRunnable(executor, root)
		executor.submit(runnable)
	}

}