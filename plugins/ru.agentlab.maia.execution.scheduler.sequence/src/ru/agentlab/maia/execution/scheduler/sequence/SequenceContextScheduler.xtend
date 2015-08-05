package ru.agentlab.maia.execution.scheduler.sequence

import java.util.LinkedList
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedExecutorScheduler

class SequenceContextScheduler implements IMaiaUnboundedExecutorScheduler {

//	val static LOGGER = LoggerFactory.getLogger(SequenceContextScheduler)
	val readyContexts = new LinkedList<IMaiaExecutorNode>

	private int currentIndex = 0

	@Inject
	IMaiaContext context

	@Accessors
	var IMaiaExecutorScheduler parentNode

//	@Inject
//	IMaiaEventBroker eventBroker
	@PostConstruct
	def void init() {
		context.set(KEY_CURRENT_CONTEXT, null)
		parentNode = context.parent.get(IMaiaExecutorScheduler)
		if (parentNode != null) {
//			LOGGER.info("Add node [{}] to scheduler [{}]...", this, parentNode)
			parentNode.add(this)
		}
	}

	override synchronized IMaiaExecutorNode getCurrentContext() {
		return context.get(KEY_CURRENT_CONTEXT) as IMaiaExecutorNode
	}

	/**
	 * Add a context at the end of the contexts queue.
	 * This can never change the index of the current context.
	 * If the contexts queue was empty notifies the embedded thread of
	 * the owner agent that a context is now available.
	 */
	override synchronized void add(IMaiaExecutorNode context) {
//		LOGGER.info("Add node [{}]", context)
		readyContexts += context
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override synchronized void remove(IMaiaExecutorNode context) {
//		LOGGER.info("Try to remove [{}] Context...", context)
		val index = readyContexts.indexOf(context)
		if (index != -1) {
//			LOGGER.debug("Scheduler removeFromReady " + context)
			val result = readyContexts.remove(context)
//			LOGGER.debug("Scheduler removeFromReady result " + result)
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
//		LOGGER.info("Try to remove all...")
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
