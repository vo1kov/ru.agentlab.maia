package ru.agentlab.maia.behaviour.primitive.doubles

import ru.agentlab.maia.behaviour.annotation.Execute
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output

class DummyActionFields {

	@Input
	var Object field1

	@Output
	var Object field2

	@Execute
	def void execute() {
		if (field1.equals(field2)) {
			field2 = new Object
		} else {
			field2 = new Object
		}
	}

}