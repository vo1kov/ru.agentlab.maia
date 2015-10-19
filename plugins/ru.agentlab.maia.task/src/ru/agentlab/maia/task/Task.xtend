package ru.agentlab.maia.task

import java.util.ArrayList
import java.util.ConcurrentModificationException
import java.util.List
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Task implements ITask {

	@Accessors
	var List<ITaskParameter<?>> inputs = null

	@Accessors
	var List<ITaskParameter<?>> outputs = null

	val protected parent = new AtomicReference<ITaskScheduler>(null)

	val protected owner = new AtomicReference<Thread>(null)

	@Accessors
	var State state = State.UNKNOWN

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

	override clearInputs() {
		inputs = null
	}

	override clearOutputs() {
		outputs = null
	}

	/**
	 * ThreadSafe! But allow only 1 thread to execute node.
	 */
	override final execute() {
		val entered = owner.compareAndSet(null, Thread.currentThread)
		if (entered) {

			state = State.WORKING
			internalExecute()

			owner.set(null)
		} else {
			throw new ConcurrentModificationException("Execution node is executing by another thread")
		}
	}

	override setState(State newState) {
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

//	def protected final void setStateFailed() {
//		state = State.FAILED
//		parent.get?.notifySubtaskFailed
//	}
//
//	def protected final void setStateSuccess() {
//		state = State.SUCCESS
//		parent.get?.notifySubtaskSuccess
//	}
//
//	def protected final void setStateBlocked() {
//		state = State.BLOCKED
//		parent.get?.notifySubtaskBlocked
//	}
//
//	def protected final void setStateReady() {
//		state = State.READY
//		parent.get?.notifySubtaskReady(this)
//	}
	def protected void internalExecute()

}