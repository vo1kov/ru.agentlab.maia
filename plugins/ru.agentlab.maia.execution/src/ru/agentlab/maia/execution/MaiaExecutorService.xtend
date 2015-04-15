package ru.agentlab.maia.execution

import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.execution.event.MaiaExecutorSubmitEvent
import ru.agentlab.maia.execution.pool.IMaiaExecutorPool

class MaiaExecutorService implements IMaiaExecutorService {

	@Inject
	IMaiaContext context

	@Inject
	IMaiaExecutorPool pool

	@Inject
	IMaiaEventBroker eventBroker

	@PostConstruct
	def void init() {
		if(pool.isFixedSize) {
			context.set(IMaiaExecutorRunnable, new MaiaExecutorFixedRunnable(context))
		} else {
			context.set(IMaiaExecutorRunnable, new MaiaExecutorUnfixedRunnable(context))
		}
	}

	def Runnable getRunnable() {
		context.get(IMaiaExecutorRunnable)
	}

	override void submitThread() {
		if (pool == null) {
			throw new IllegalStateException("Executor Pool is null")
		}
		pool.submit(runnable)
		eventBroker.post(new MaiaExecutorSubmitEvent(context))

	// TODO: add this runnable to pool after execution
	}

}