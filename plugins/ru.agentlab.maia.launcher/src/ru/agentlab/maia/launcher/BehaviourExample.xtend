package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.agent.IScheduler
import ru.agentlab.maia.behaviour.IBehaviour
import ru.agentlab.maia.context.IContextFactory

class BehaviourExample {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample)

	@Inject
	@Named(IContextFactory.KEY_NAME)
	String behName

	@Inject
	IEclipseContext context
	
	@Inject
	IScheduler sch

	@PostConstruct
	def void init() {
		var c = context
		while (c != null) {
			LOGGER.debug("Context [{}] hold:", c)
			(c as EclipseContext).localData.forEach [ p1, p2 |
				LOGGER.debug("	[{}] -> [{}]", p1, p2)
			]
			c = c.parent
		}
	}

	@Action(type=IBehaviour.TYPE_TICKER)
	@ActionTicker(period=500, fixedPeriod=false)
	def void action() {
		LOGGER.info("Behaviour [{}] timestamp [{}]", behName, System.currentTimeMillis)
		LOGGER.info("{}", sch.hashCode)
	}

}