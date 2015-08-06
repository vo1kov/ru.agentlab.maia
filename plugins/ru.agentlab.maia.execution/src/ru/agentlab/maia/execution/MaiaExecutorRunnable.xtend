package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService

class MaiaExecutorRunnable implements IMaiaExecutorRunnable {

	IMaiaExecutorNode root

	ExecutorService executor

	new(ExecutorService executor, IMaiaExecutorNode root) {
		this.executor = executor
		this.root = root
	}

	override run() {
		try {
			val action = root.getAction
			action.run
			executor.submit(this)
		} catch (Exception e) {
		}
	}

	def private IMaiaExecutorAction getAction(IMaiaExecutorNode node) {
		switch (node) {
			IMaiaExecutorAction: {
				return node
			}
			IMaiaExecutorScheduler: {
				val next = node.nextNode
				return getAction(next)
			}
			default: {
				throw new IllegalStateException
			}
		}
	}
}
