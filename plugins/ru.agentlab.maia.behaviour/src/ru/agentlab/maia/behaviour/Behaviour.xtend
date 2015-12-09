package ru.agentlab.maia.behaviour

import java.util.ArrayList
import java.util.List
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors

abstract class Behaviour implements IBehaviour {

	@Accessors
	var String label

	@Accessors(PUBLIC_GETTER)
	var List<IBehaviourParameter<?>> inputs = null

	@Accessors(PUBLIC_GETTER)
	var List<IBehaviourParameter<?>> outputs = null

	@Accessors(PUBLIC_GETTER)
	var List<IBehaviourException> exceptions = null

	val protected parent = new AtomicReference<IBehaviourScheduler>(null)

//	val protected owner = new AtomicReference<Thread>(null)
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

	/**
	 * Add Input Parameter to behaviour 
	 */
	override void addInput(IBehaviourParameter<?> parameter) {
		if (inputs === null) {
			inputs = new ArrayList<IBehaviourParameter<?>>
		}
		inputs += parameter
	}

	/**
	 * Add Output Parameter to behaviour 
	 */
	override void addOutput(IBehaviourParameter<?> parameter) {
		if (outputs === null) {
			outputs = new ArrayList<IBehaviourParameter<?>>
		}
		outputs += parameter
	}

	/**
	 * Add Exception to behaviour 
	 */
	override addException(IBehaviourException exception) {
		if (exceptions === null) {
			exceptions = new ArrayList<IBehaviourException>
		}
		exceptions += exception
	}

	/**
	 * Remove Input Parameter from behaviour and if it is last then remove entire list
	 */
	override removeInput(IBehaviourParameter<?> parameter) {
		if (inputs != null) {
			inputs.remove(parameter)
			if (inputs.empty) {
				inputs = null
			}
		}
	}

	/**
	 * Remove Output Parameter from behaviour and if it is last then remove entire list
	 */
	override removeOutput(IBehaviourParameter<?> parameter) {
		if (outputs != null) {
			outputs.remove(parameter)
			if (outputs.empty) {
				outputs = null
			}
		}
	}

	/**
	 * Remove Exception from behaviour and if it is last then remove entire list
	 */
	override removeException(IBehaviourException exception) {
		if (exception != null) {
			exceptions.remove(exception)
			if (exceptions.empty) {
				exceptions = null
			}
		}
	}

	/**
	 * Remove all Inputs from behaviour
	 */
	override clearInputs() {
		inputs = null
	}

	/**
	 * Remove all Outputs from behaviour
	 */
	override clearOutputs() {
		outputs = null
	}

	/**
	 * Remove all Exceptions from behaviour
	 */
	override clearExceptions() {
		exceptions = null
	}

//	/**
//	 * ThreadSafe! But allow only 1 thread to execute node.
//	 */
//	override final execute() {
//		val entered = owner.compareAndSet(null, Thread.currentThread)
//		if (entered) {
//			if (!(state === BehaviourState.READY || state === BehaviourState.WORKING)) {
//				throw new IllegalStateException("Task in illegal state; " + state)
//			}
//			internalExecute()
//			owner.set(null)
//		} else {
//			throw new ConcurrentModificationException("Execution node is executing by another thread")
//		}
//	}
	def protected void setSuccessState() {
		state = BehaviourState.SUCCESS
		parent.get?.notifyChildSuccess
	}

	def protected void setFailedState(IBehaviourException e) {
		state = BehaviourState.FAILED
		parent.get?.notifyChildFailed(e)
	}

	def protected void setBlockedState() {
		state = BehaviourState.BLOCKED
		parent.get?.notifyChildBlocked
	}

	def protected void setWorkingState() {
		state = BehaviourState.WORKING
		parent.get?.notifyChildWorking
	}

	def protected void setReadyState() {
		state = BehaviourState.READY
		parent.get?.notifyChildReady(this)
	}

//	override setState(BehaviourState newState) {
//		val old = state
//		state = newState
//		switch (newState) {
//			case UNKNOWN: {
//			}
//			case READY: {
//				parent.get?.notifyChildReady(this)
//			}
//			case WORKING: {
//				parent.get?.notifyChildWorking
//			}
//			case BLOCKED: {
//				parent.get?.notifyChildBlocked
//			}
//			case SUCCESS: {
//				parent.get?.notifyChildSuccess
//			}
//			case FAILED: {
//				parent.get?.notifyChildFailed
//			}
//		}
//		println("Task " + this + " change state to " + newState)
//		return old
//	}
//	def protected void internalExecute()
//	override equals(Object obj) {
//		if(obj instanceof Task){
//			return false
//		} else {
//			return false
//		}
//	}
}
