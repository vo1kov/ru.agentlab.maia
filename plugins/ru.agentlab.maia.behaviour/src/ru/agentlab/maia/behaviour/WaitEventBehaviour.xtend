package ru.agentlab.maia.behaviour

import java.util.Map
import ru.agentlab.maia.event.IMaiaEventBroker

class WaitEventBehaviour extends Behaviour {

	var IMaiaEventBroker broker

	val Parameter<String> topic

	val Parameter<Map<?, ?>> data

	new() {
		topic = new Parameter("topic", String)
		data = new Parameter("data", Map)
		addInput(topic)
		addOutput(data)
	}

	override execute() {
		// Add listener
		broker.subscribe(topic.value, [event |
//			val agent = new Agent(null)
//			agent.submit [
//				this.data.value = event.data
//				this.state = State.READY
//			]
		])

		// Change state to clocked
		state = State.BLOCKED
	}

}
