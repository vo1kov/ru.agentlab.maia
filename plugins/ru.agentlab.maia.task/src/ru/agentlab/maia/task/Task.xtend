package ru.agentlab.maia.task

import java.util.ArrayList
import java.util.ConcurrentModificationException
import java.util.List
import java.util.UUID
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Task implements ITask {

	@Accessors
	val String uuid

	@Accessors
	var String label

	@Accessors
	var List<ITaskParameter<?>> inputs = null

	@Accessors
	var List<ITaskParameter<?>> outputs = null

	@Accessors
	var List<ITaskException> exceptions = null

	val protected parent = new AtomicReference<ITaskScheduler>(null)

	val protected owner = new AtomicReference<Thread>(null)

	@Accessors
	var TaskState state = TaskState.UNKNOWN

	new() {
		this.uuid = UUID.randomUUID.toString
	}

	new(String uuid) {
		this.uuid = uuid
	}

	/**
	 * ThreadSafe!
	 */
	override setParent(ITaskScheduler newParent) {
		val oldParent = parent.getAndSet(newParent)
		if (oldParent != null && oldParent != newParent) {
			oldParent.removeSubtask(this)
		}
	}

	/**
	 * ThreadSafe!
	 */
	override ITaskScheduler getParent() {
		return parent.get
	}

	override void addInput(ITaskParameter<?> parameter) {
		if (inputs === null) {
			inputs = new ArrayList<ITaskParameter<?>>
		}
		inputs += parameter
	}

	override void addOutput(ITaskParameter<?> parameter) {
		if (outputs === null) {
			outputs = new ArrayList<ITaskParameter<?>>
		}
		outputs += parameter
	}

	override addException(ITaskException exception) {
		if (exceptions === null) {
			exceptions = new ArrayList<ITaskException>
		}
		exceptions += exception
	}

	override removeInput(ITaskParameter<?> parameter) {
		if (inputs !== null) {
			inputs.remove(parameter)
		}
	}

	override removeOutput(ITaskParameter<?> parameter) {
		if (outputs !== null) {
			outputs.remove(parameter)
		}
	}

	override removeException(ITaskException exception) {
		if (exceptions !== null) {
			exceptions.remove(exception)
		}
	}

	override clearInputs() {
		inputs = null
	}

	override clearOutputs() {
		outputs = null
	}

	override clearExceptions() {
		exceptions = null
	}

	/**
	 * ThreadSafe! But allow only 1 thread to execute node.
	 */
	override final execute() {
		val entered = owner.compareAndSet(null, Thread.currentThread)
		if (entered) {
			if (!(state === TaskState.READY || state === TaskState.WORKING)) {
				throw new IllegalStateException("Task in illegal state; " + state)
			}
			internalExecute()
			owner.set(null)
		} else {
			throw new ConcurrentModificationException("Execution node is executing by another thread")
		}
	}

	override setState(TaskState newState) {
		val old = state
		state = newState
		switch (newState) {
			case UNKNOWN: {
			}
			case READY: {
				parent.get?.notifySubtaskReady(this)
			}
			case WORKING: {
				parent.get?.notifySubtaskWorking
			}
			case BLOCKED: {
				parent.get?.notifySubtaskBlocked
			}
			case SUCCESS: {
				parent.get?.notifySubtaskSuccess
			}
			case FAILED: {
				parent.get?.notifySubtaskFailed
			}
		}
		println("Task " + this + " change state to " + newState)
		return old
	}

	def protected void internalExecute()

//	override equals(Object obj) {
//		if(obj instanceof Task){
//			return false
//		} else {
//			return false
//		}
//	}
}