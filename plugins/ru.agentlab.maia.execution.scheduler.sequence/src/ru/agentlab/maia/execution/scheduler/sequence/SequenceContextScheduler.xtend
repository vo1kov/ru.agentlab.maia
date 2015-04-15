package ru.agentlab.maia.execution.scheduler.sequence

import java.util.concurrent.ConcurrentLinkedDeque
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedContextScheduler

class SequenceContextScheduler implements IMaiaUnboundedContextScheduler {

	val static LOGGER = LoggerFactory.getLogger(SequenceContextScheduler)

	val readyContexts = new ConcurrentLinkedDeque<IMaiaContext>

	val blockedContexts = new ConcurrentLinkedDeque<IMaiaContext>

	private transient Object suspendLock = new Object

	private transient Object contextsLock = new Object

	private int currentIndex = 0

	@Inject
	IMaiaContext conext

	@PostConstruct
	def void init() {
		conext.set(KEY_CURRENT_CONTEXT, null)
	}

	override IMaiaContext getCurrentContext() {
		return conext.get(KEY_CURRENT_CONTEXT) as IMaiaContext
	}

	/**
	 * Add a context at the end of the contexts queue.
	 * This can never change the index of the current context.
	 * If the contexts queue was empty notifies the embedded thread of
	 * the owner agent that a context is now available.
	 */
	override void add(IMaiaContext context) {
		synchronized (contextsLock) {
			readyContexts += context
		}
		doNotify
	}

//	/**
//	 * Moves a context from the ready queue to the sleeping queue. 
//	 */
//	override void block(IMaiaContext context) {
//		LOGGER.info("Try to block [{}] Context...", context)
//		synchronized (contextsLock) {
//			if (context.removeFromReady) {
//				blockedContexts += context
//			}
//		}
//	}
//
//	override void blockAll() {
//		LOGGER.info("Try to block all...")
//		synchronized (contextsLock) {
//			blockedContexts += readyContexts
//			readyContexts.clear
//			currentIndex = 0
//		}
//	}
//
//	/**
//	 * Moves a context from the sleeping queue to the ready queue.
//	 */
//	override void restart(IMaiaContext context) {
//		LOGGER.info("Try to remove [{}] Context...", context)
//		synchronized (contextsLock) {
//			if (context.removeFromBlocked) {
//				readyContexts += context
//			}
//			doNotify
//		}
//	}
//
//	/** 
//	 * Restarts all contexts. This method simply calls IContext.restart() on
//	 * every context. The IContext.restart() method then notifies the agent
//	 * (with the Agent.notifyRestarted() method), causing Scheduler.restart() to
//	 * be called (this also moves contexts from the blocked queue to the ready
//	 * queue --> we must copy all contexts into a temporary buffer to avoid
//	 * concurrent modification exceptions). Why not restarting only blocked
//	 * contexts? Some ready context can be a ParallelIContext with some of its
//	 * children blocked. These children must be restarted too.
//	 */
//	override void restartAll() {
//		LOGGER.info("Try to restart all...")
//		synchronized (contextsLock) {
//			readyContexts += blockedContexts
//			blockedContexts.clear
//			currentIndex = 0
//			doNotify
//		}
//	}
	/** 
	 * Removes a specified context from the scheduler
	 */
	override void remove(IMaiaContext context) {
		LOGGER.info("Try to remove [{}] Context...", context)
		synchronized (contextsLock) {
			removeFromBlocked(context)
			removeFromReady(context)
		}
	}

	/** 
	 * Removes a specified context from the scheduler
	 */
	override void removeAll() {
		LOGGER.info("Try to remove all...")
		synchronized (contextsLock) {
			readyContexts.clear
			blockedContexts.clear
			currentIndex = 0
		}
	}

	/**
	 *  Removes a specified context from the blocked queue.
	 */
	def private boolean removeFromBlocked(IMaiaContext context) {
		LOGGER.info("Try to remove [{}] context from blocked...", context)
//		synchronized (contextsLock) {
		return blockedContexts.remove(context)
//		}
	}

	/**
	 * Removes a specified context from the ready queue.
	 * This can change the index of the current context, so a check is
	 * made: if the just removed context has an index lesser than the
	 * current one, then the current index must be decremented.
	 */
	def private boolean removeFromReady(IMaiaContext context) {
		LOGGER.info("Try to remove [{}] Context from ready...", context)
		var boolean result
//		val index = readyContexts.indexOf(context)
//		if (index != -1) {
//			LOGGER.debug("Scheduler removeFromReady " + context)
//			result = readyContexts.remove(context)
//			LOGGER.debug("Scheduler removeFromReady result " + result)
//			if (index < currentIndex) {
//				currentIndex = currentIndex - 1
//			} else if (index == currentIndex && currentIndex == readyContexts.size())
//				currentIndex = 0
//		}
		return result
	}

	def private void doNotify() {
		synchronized (suspendLock) {
			LOGGER.info("Notify...")
			suspendLock.notify
		}
	}

//	def private void doWait() {
//		synchronized (suspendLock) {
//			LOGGER.info("Begin waiting...")
//			suspendLock.wait
//		}
//	}
	override synchronized getNextContext() {
		if (readyContexts.empty) {
			return null
		} else {
			currentIndex = (currentIndex + 1) % readyContexts.size()
			return readyContexts.get(currentIndex)
		}
	}

}
