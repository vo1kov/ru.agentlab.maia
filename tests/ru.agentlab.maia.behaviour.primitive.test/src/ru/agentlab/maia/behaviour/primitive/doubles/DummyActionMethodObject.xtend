package ru.agentlab.maia.behaviour.primitive.doubles

import ru.agentlab.maia.behaviour.annotation.Execute

class DummyActionMethodObject {

	@Execute
	def Object execute(String param, Object param2) {
		return param.toString + param2.toString
	}

}