package ru.agentlab.maia.execution

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.naming.IMaiaContextNameFactory
import ru.agentlab.maia.context.typing.IMaiaContextTyping
import ru.agentlab.maia.execution.action.IMaiaContextAction
import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler

class MaiaExecutorUnfixedRunnable implements IMaiaExecutorRunnable {

	val static LOGGER = LoggerFactory.getLogger(MaiaExecutorFixedRunnable)

	var IMaiaContext context

	val Object lock = new Object

	new(IMaiaContext context) {
		this.context = context
	}

	def IMaiaContextAction getAction(IMaiaExecutorNode node) {
		LOGGER.debug("Current Node: [{}]", node)
		if (node instanceof IMaiaContextAction) {
			LOGGER.debug("	current node is IMaiaContextAction")
			return node
		} else if (node instanceof IMaiaExecutorScheduler) {
			LOGGER.debug("	current node is IMaiaExecutorScheduler")
			return getAction(node.nextContext)
		}
	}

	override run() {
		val contextType = context.get(IMaiaContextTyping.KEY_TYPE) as String
		val contextName = context.get(IMaiaContextNameFactory.KEY_NAME) as String
		Thread.currentThread.name = contextType + ": " + contextName

		while (true) {
			try {
				LOGGER.debug("Start execution loop...")
				val currentNode = context.get(IMaiaExecutorNode)
				currentNode.getAction => [
					if (it != null) {
						beforeRun
						run
						afterRun
					}
				]
				Thread.sleep(20000)
			} catch (Exception e) {
				LOGGER.error("Some exception", e)
			}
		}
	}
	
}