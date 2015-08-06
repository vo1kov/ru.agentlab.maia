package ru.agentlab.maia.execution.scheduler.sequence

import java.util.LinkedList
import javax.annotation.PostConstruct
import javax.inject.Inject
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.IMaiaExecutorNode
import ru.agentlab.maia.execution.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedExecutorScheduler

class SequenceContextScheduler implements IMaiaUnboundedExecutorScheduler {

	val readyContexts = new LinkedList<IMaiaExecutorNode>

	private int currentIndex = 0

	@Inject
	IMaiaContext context

	var IMaiaExecutorScheduler parentScheduler

	@PostConstruct
	def void init() {
		val oldScheduler = context.getLocal(IMaiaExecutorScheduler)
		if (oldScheduler != null) {
			oldScheduler.removeAll
		}
		context.set(KEY_CURRENT_CONTEXT, null)
		parentScheduler = context.parent.get(IMaiaExecutorScheduler)
//		if (parentScheduler != null) {
//			parentScheduler.add(this)
//		}
	}

	override synchronized IMaiaExecutorNode getCurrentNode() {
		return context.get(KEY_CURRENT_CONTEXT) as IMaiaExecutorNode
	}

	/**
	 * Add a context at the end of the contexts queue.
	 * This can never change the index of the current context.
	 * If the contexts queue was empty notifies the embedded thread of
	 * the owner agent that a context is now available.
	 */
	override synchronized void add(IMaiaExecutorNode node) {
		if (!readyContexts.contains(node)) {
			readyContexts += node
			if (parentScheduler != null) {
				parentScheduler.add(this)
			}
		}
	}

	/** 
	 * Removes a specified node from the scheduler
	 */
	override synchronized void remove(IMaiaExecutorNode node) {
		val index = readyContexts.indexOf(node)
		if (index != -1) {
			readyContexts.remove(node)
			if (index < currentIndex) {
				currentIndex = currentIndex - 1
			} else if (index == currentIndex && currentIndex == readyContexts.size())
				currentIndex = 0
			if (empty) {
				if (parentScheduler != null) {
					parentScheduler.remove(this)
				}
			}
		}
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override synchronized void removeAll() {
		readyContexts.clear
		currentIndex = 0
	}

	override synchronized getNextNode() {
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
