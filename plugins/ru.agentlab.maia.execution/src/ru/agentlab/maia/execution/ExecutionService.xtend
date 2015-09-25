package ru.agentlab.maia.execution

import java.util.concurrent.ExecutorService
import java.util.concurrent.atomic.AtomicBoolean
import javax.inject.Inject

class ExecutionService implements IExecutionService {

	@Inject
	ExecutorService executor

	@Inject
	IExecutionNode node

	val isActive = new AtomicBoolean(false)

	override void start() {
		isActive.set(true)
		executor.submit(new Runnable {
			override run() {
				if (active) {
					switch (node) {
						IExecutionScheduler: {
							val childs = node.schedule
							if (childs.size > 1) {
							}
							for (child : childs) {
							}
						}
						IExecutionAction: {
							node.run
						}
					}
					if (!node.done) {
						executor.submit(this)
					}
				}
			}
		})
	}

	override void submit(IExecutionNode node) {
	}

	override void stop() {
		isActive.set(false)
	}

	override isActive() {
		isActive.get
	}

}

class MaiaWorker implements Runnable {

	IExecutionService service

	IExecutionNode node
	
	@Inject
	new(IExecutionService service, IExecutionNode node){
		this.service = service
		this.node = node
	}

	override run() {
		if (service.active) {
			switch (node) {
				IExecutionScheduler: {
					val childs = node.schedule
					if (childs.size > 0) {
						for (i : 1 ..< childs.size) {
							
						}
					}
				}
				IExecutionAction: {
					node.run
				}
			}
			if (!node.done) {
				service.submit(node)
			}
		}
	}

}