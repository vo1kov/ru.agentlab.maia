package ru.agentlab.maia.execution.node

import java.util.concurrent.CopyOnWriteArrayList
import java.util.concurrent.atomic.AtomicReference
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.execution.IExecutionParameter
import ru.agentlab.maia.execution.IStateChangedListener
import java.util.concurrent.CopyOnWriteArraySet

@Accessors
abstract class AbstractExecutionParameter<T> implements IExecutionParameter<T> {

	val protected String name

	val protected Class<T> type

	val protected state = new AtomicReference<String>(IExecutionParameter.UNLINKED)

	val protected linked = new CopyOnWriteArraySet<IExecutionParameter<T>>

	val protected value = new AtomicReference<T>

	val protected boolean isOptional

	val protected listeners = new CopyOnWriteArrayList<IStateChangedListener<IExecutionParameter<T>>>

	new(String name, Class<T> type, boolean isOptional) {
		this.name = name
		this.type = type
		this.isOptional = isOptional
	}
	
	override getLinked() {
		return linked
	}

	// --------------------------------------------
	// Value manipulations
	// --------------------------------------------
	override setValue(T v) {
		value.set(v)
	}

	override getValue() {
		value.get
	}

	// --------------------------------------------
	// Connection manipulations
	// --------------------------------------------
	override link(IExecutionParameter<T> param) {
		val added = linked.add(param)
		if (added) {
			state = LINKED
		}
	}

	override unlink(IExecutionParameter<T> param) {
		val removed = linked.remove(param)
		if (removed) {
			if (linked.empty) {
				state = UNLINKED
			} else {
				state = LINKED
			}
		}
	}

	// --------------------------------------------
	// State manipulations
	// --------------------------------------------
	override String getState() {
		return state.get
	}

	override setState(String newState) {
		val oldState = state.getAndSet(newState)
		if (oldState != newState) {
			listeners.forEach [
				onStateChanged(this, oldState, newState)
			]
		}
		return oldState
	}

	override addStateListener(IStateChangedListener<IExecutionParameter<T>> listener) {
		listeners += listener
	}

	override removeStateListener(IStateChangedListener<IExecutionParameter<T>> listener) {
		listeners -= listener
	}
}