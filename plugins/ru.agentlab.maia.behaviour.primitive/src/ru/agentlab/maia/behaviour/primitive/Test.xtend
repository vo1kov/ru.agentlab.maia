package ru.agentlab.maia.behaviour.primitive

import ru.agentlab.maia.behaviour.annotation.Execute
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output

class Test {

	@Input
	@Output
	@Execute
	def String exe(String from) {
		return from.toFirstUpper
	}

	def static void main(String[] args) {
		val action = new BehaviourPrimitive(new Test)
		action.execute
	}

}