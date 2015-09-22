package ru.agentlab.maia.execution.node

import ru.agentlab.maia.execution.tree.IDataParameter

interface IParameterStateChangedHandler {

	def void handleParameterChangedState(IDataParameter<?> parameter, Integer oldState, Integer newState)

}