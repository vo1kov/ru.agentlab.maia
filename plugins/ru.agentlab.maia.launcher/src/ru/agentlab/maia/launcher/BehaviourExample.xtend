package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.e4.core.internal.contexts.EclipseContext
import org.slf4j.LoggerFactory
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.behaviour.IBehaviour

class BehaviourExample {

	val static LOGGER = LoggerFactory.getLogger(BehaviourExample)

	@Inject
	@Named(IBehaviour.KEY_NAME)
	String behName

	@Inject
	IEclipseContext context

	@PostConstruct
	def void init() {
		(context as EclipseContext).localData.forEach [ p1, p2 |
			LOGGER.info("Context Data: [{}] -> [{}]", p1, p2)
		]
	}

	@Action(type=IBehaviour.TYPE_TICKER)
	@ActionTicker(period=500, fixedPeriod=false)
	def void action() {
		LOGGER.info("Behaviour [{}] timestamp [{}]", behName, System.currentTimeMillis)
	}

}