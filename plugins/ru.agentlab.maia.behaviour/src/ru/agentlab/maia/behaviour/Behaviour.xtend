package ru.agentlab.maia.behaviour

import java.util.ArrayList
import java.util.ConcurrentModificationException
import java.util.List
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Behaviour implements IBehaviour {

	@Accessors
	var String label

	@Accessors
	var List<IBehaviourParameter<?>> inputs = null

	@Accessors
	var List<IBehaviourParameter<?>> outputs = null

	@Accessors
	var List<IBehaviourException> exceptions = null

	val protected parent = new AtomicReference<IBehaviourScheduler>(null)

	val protected owner = new AtomicReference<Thread>(null)

	@Accessors
	var BehaviourState state = BehaviourState.UNKNOWN

	/**
	 * ThreadSafe!
	 */
	override setParent(IBehaviourScheduler newParent) {
		val oldParent = parent.getAndSet(newParent)
		if (oldParent != null && oldParent != newParent) {
			oldParent.removeChild(this)
		}
	}

	/**
	 * ThreadSafe!
	 */
	override IBehaviourScheduler getParent() {
		return parent.get
	}

	override void addInput(IBehaviourParameter<?> parameter) {
		if (inputs === null) {
			inputs = new ArrayList<IBehaviourParameter<?>>
		}
		inputs += parameter
	}

	override void addOutput(IBehaviourParameter<?> parameter) {
		if (outputs === null) {
			outputs = new ArrayList<IBehaviourParameter<?>>
		}
		outputs += parameter
	}

	override addException(IBehaviourException exception) {
		if (exceptions === null) {
			exceptions = new ArrayList<IBehaviourException>
		}
		exceptions += exception
	}

	override removeInput(IBehaviourParameter<?> parameter) {
		if (inputs !== null) {
			inputs.remove(parameter)
		}
	}

	override removeOutput(IBehaviourParameter<?> parameter) {
		if (outputs !== null) {
			outputs.remove(parameter)
		}
	}

	override removeException(IBehaviourException exception) {
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
			if (!(state === BehaviourState.READY || state === BehaviourState.WORKING)) {
				throw new IllegalStateException("Task in illegal state; " + state)
			}
			internalExecute()
			owner.set(null)
		} else {
			throw new ConcurrentModificationException("Execution node is executing by another thread")
		}
	}

	override setState(BehaviourState newState) {
		val old = state
		state = newState
		switch (newState) {
			case UNKNOWN: {
			}
			case READY: {
				parent.get?.notifyChildReady(this)
			}
			case WORKING: {
				parent.get?.notifyChildWorking
			}
			case BLOCKED: {
				parent.get?.notifyChildBlocked
			}
			case SUCCESS: {
				parent.get?.notifyChildSuccess
			}
			case FAILED: {
				parent.get?.notifyChildFailed
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