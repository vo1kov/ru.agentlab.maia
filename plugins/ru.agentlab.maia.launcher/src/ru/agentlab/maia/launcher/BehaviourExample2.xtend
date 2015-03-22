package ru.agentlab.maia.launcher

import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.Action
import ru.agentlab.maia.ActionTicker
import ru.agentlab.maia.agent.IAgent
import ru.agentlab.maia.behaviour.IBehaviour

class BehaviourExample2 {

	@Inject
	@Named(IBehaviour.KEY_NAME)
	String behName

	@Inject
	@Named(IAgent.KEY_NAME)
	String agentName

	@Action(type=IBehaviour.TYPE_TICKER)
	@ActionTicker(period=600, fixedPeriod=false)
	def void action() {
		println('''«agentName»::«behName» - «System.currentTimeMillis»''')
	}

}