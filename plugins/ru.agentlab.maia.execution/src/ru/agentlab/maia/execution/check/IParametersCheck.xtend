package ru.agentlab.maia.execution.check

import ru.agentlab.maia.execution.tree.IDataParameter

interface IParametersCheck extends ICheck {

	def boolean test(Iterable<IDataParameter> parameters)

}