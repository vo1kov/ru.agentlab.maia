package ru.agentlab.maia.execution.scheduler.fsm

import java.util.ArrayList
import java.util.List
import ru.agentlab.maia.execution.scheduler.fsm.transition.DefaultFsmTransition
import ru.agentlab.maia.execution.scheduler.fsm.transition.IFsmTransition
import ru.agentlab.maia.execution.tree.ExecutionNodeState
import ru.agentlab.maia.execution.tree.IExecutionNode
import ru.agentlab.maia.execution.tree.IllegalSchedulerStateException
import ru.agentlab.maia.execution.tree.impl.AbstractScheduler

class FsmScheduler extends AbstractScheduler implements IFsmScheduler {

	val List<IFsmTransition> transitions = new ArrayList<IFsmTransition>

	def void addTransition(String name, IExecutionNode from, IExecutionNode to) {
		val existing = transitions.findFirst[it.from == from && it.to == to]
		if (existing == null) {
			transitions += new DefaultFsmTransition(name, from, to)
		}
	}

	override getNextChild() throws IllegalSchedulerStateException {
		if (state == ExecutionNodeState.ACTIVE) {
		} else {
			throw new IllegalSchedulerStateException("Only Scheduler in ACTIVE state can schedule.")
		}
	}

}