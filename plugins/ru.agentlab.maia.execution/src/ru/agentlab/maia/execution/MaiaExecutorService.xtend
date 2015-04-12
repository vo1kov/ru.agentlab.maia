package ru.agentlab.maia.execution

import javax.inject.Inject
import ru.agentlab.maia.IMaiaContext
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool
import ru.agentlab.maia.execution.scheduler.IScheduler

class MaiaExecutorService implements IMaiaExecutorService {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaExecutorPool pool

	override void submitThread() {
		if (pool == null) {
			throw new IllegalStateException("Executor Pool is null")
		}
		pool.submit(
			new Runnable {
				override run() {
					// test home context
					var currentContext = context
					var action = currentContext.get(IMaiaContextAction)
					while (currentContext != null && action == null) {
						val scheduler = currentContext.get(IScheduler)
						synchronized (scheduler) {
							// get next context via scheduler that have no its own Executor service
							currentContext = scheduler.nextContext
							var executor = currentContext.get(IMaiaExecutorService)
							// find context without it's own executor 
							while (executor != null) {

								// TODO: fix possible infinite loop
								currentContext = scheduler.nextContext
								executor = currentContext.get(IMaiaExecutorService)
							}
							action = currentContext.get(IMaiaContextAction)
						}
					}
					if (action != null) {
						action.beforeRun
						action.run
						action.afterRun
					}
				}
			}
		)
		// TODO: add this runnable to pool after execution
	}

}