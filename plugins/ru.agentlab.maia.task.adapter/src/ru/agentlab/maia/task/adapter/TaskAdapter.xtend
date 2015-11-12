package ru.agentlab.maia.task.adapter

import ru.agentlab.maia.task.ITask

class TaskAdapter<F> implements IAdapter<F, ITask> {

	val cache = new TaskAdapterCache

	override adapt(F json) {
	}

}