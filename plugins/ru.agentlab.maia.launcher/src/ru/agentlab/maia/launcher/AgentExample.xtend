package ru.agentlab.maia.launcher

import javax.annotation.PostConstruct
import javax.inject.Inject
import javax.inject.Named
import ru.agentlab.maia.IAgent
import ru.agentlab.maia.IBehaviour
import ru.agentlab.maia.annotation.Setup
import ru.agentlab.maia.scheduler.IScheduler

class AgentExample {

	@Inject
	IAgent agent
	
	@Inject @Named(IAgent.KEY_NAME)
	String agentName

	@Inject
	IScheduler scheduler

	@Setup
	def void setup() {
		// does not work...
		println("SETUP of: " + agent + " agent")
	}

	@PostConstruct
	def void setup2() {
		println("SETUP2 of: [" + agent.name + "] agent")
		println("SETUP2 of: [" + agentName + "] agent")
		scheduler.add(new IBehaviour() {

			override action() {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}

			override getState() {
				"TEST"
			}

			override done() {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}

			override onEnd() {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}

			override onStart() {
				throw new UnsupportedOperationException("TODO: auto-generated method stub")
			}

		})
		println(scheduler.behaviours.size)
		scheduler.behaviours.forEach [
			println('''«it» STATE -> [«state»]''')
		]
	}
}