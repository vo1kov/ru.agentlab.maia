package ru.agentlab.maia.execution.check.parameters

import ru.agentlab.maia.execution.check.IParametersCheck
import ru.agentlab.maia.execution.tree.IDataParameter

class AllParametersHaveKey implements IParametersCheck {
	
	override test(Iterable<IDataParameter> parameters) {
		return parameters.findFirst[key == null] == null
	}
	
}