package ru.agentlab.maia.execution

import java.util.LinkedList
import java.util.concurrent.RecursiveAction

class ExecutionTask extends RecursiveAction {

	val IExecutionNode node

	new(IExecutionNode node) {
		this.node = node
	}

	override protected compute() {
		switch (node) {
			IExecutionScheduler: {
				val childs = node.schedule
				val subTasks = new LinkedList<ExecutionTask>
				for (child : childs) {
					val task = new ExecutionTask(child)
					subTasks += task
					task.fork
				}
				for (task : subTasks) {
					task.join
				}
			}
			IExecutionAction: {
				node.run
			}
		}
	}

}