package ru.agentlab.maia.execution.scheduler.sequence

import org.slf4j.LoggerFactory
import ru.agentlab.maia.context.IMaiaContext
import ru.agentlab.maia.context.event.MaiaContextSetObjectEvent
import ru.agentlab.maia.event.IMaiaEventBroker
import ru.agentlab.maia.execution.node.IMaiaExecutorNode
import ru.agentlab.maia.execution.scheduler.IMaiaExecutorScheduler
import ru.agentlab.maia.execution.scheduler.unbounded.IMaiaUnboundedContextScheduler

class ChildContextListener {

	val static LOGGER = LoggerFactory.getLogger(ChildContextListener)

	IMaiaContext context

	IMaiaUnboundedContextScheduler scheduler

	IMaiaEventBroker eventBroker

	new(IMaiaContext context, IMaiaUnboundedContextScheduler scheduler, IMaiaEventBroker eventBroker) {
		this.context = context
		this.scheduler = scheduler
		this.eventBroker = eventBroker
		init
	}

	def void init() {
		context.childs?.forEach [
			val node = get(IMaiaExecutorNode)
			if (node != null) {
				LOGGER.info("Add node [{}] to scheduler [{}]...", node, scheduler)
				scheduler.add(node)
			}
		]
		eventBroker.subscribe(MaiaContextSetObjectEvent.TOPIC, [
			val event = it as MaiaContextSetObjectEvent
			val obj = event.object
			if (obj instanceof IMaiaExecutorNode) {
				val context = event.context
				val scheduler = context.parent.get(IMaiaExecutorScheduler)
				if (scheduler instanceof IMaiaUnboundedContextScheduler) {
					LOGGER.info("Add node [{}] to scheduler [{}]...", obj, scheduler)
					scheduler?.add(obj)
				}
			}
		])
	}
}