package ru.agentlab.maia.execution.scheduler.sequence

import java.util.LinkedList
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedContextScheduler

class SequenceContextScheduler implements IMaiaUnboundedContextScheduler {

	val static LOGGER = LoggerFactory.getLogger(SequenceContextScheduler)

	val protected readyContexts = new LinkedList<IMaiaExecutorNode>

	private int currentIndex = -1

	IMaiaContext context

	@Inject
	new(IMaiaContext context) {
		this.context = context
	}

	@PostConstruct
	def void init() {
		context.set(KEY_CURRENT_CONTEXT, null)
		val parentScheduler = context.parent.get(IMaiaExecutorScheduler)
		if (parentScheduler != null) {
			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentScheduler)
			parentScheduler?.add(this)
		}
	}

	override synchronized IMaiaExecutorNode getCurrentContext() {
		val result = context.getLocal(KEY_CURRENT_CONTEXT)
		if (result != null) {
			return result as IMaiaExecutorNode
		} else {
			return null
		}
	}

	/**
	 * Add a context at the end of the contexts queue.
	 * This can never change the index of the current context.
	 * If the contexts queue was empty notifies the embedded thread of
	 * the owner agent that a context is now available.
	 */
	override synchronized void add(IMaiaExecutorNode context) {
//		LOGGER.info("Add node [{}]", context)
		if (!readyContexts.contains(context)) {
			readyContexts += context
		}
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override synchronized void remove(IMaiaExecutorNode context) {
		LOGGER.info("Try to remove [{}] Context...", context)

		val index = readyContexts.indexOf(context)
		if (index != -1) {
			LOGGER.debug("Scheduler removeFromReady " + context)
			val result = readyContexts.remove(context)
			LOGGER.debug("Scheduler removeFromReady result " + result)
			if (index < currentIndex) {
				currentIndex = currentIndex - 1
			} else if (index == currentIndex && currentIndex == readyContexts.size())
				currentIndex = 0
		}
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override synchronized void removeAll() {
		LOGGER.info("Try to remove all...")
		readyContexts.clear
		currentIndex = 0
	}

	override synchronized getNextContext() {
		if (readyContexts.empty) {
			return null
		} else {
			currentIndex = (currentIndex + 1) % readyContexts.size()
			return readyContexts.get(currentIndex)
		}
	}

	override synchronized isEmpty() {
		return readyContexts.empty
	}

}
