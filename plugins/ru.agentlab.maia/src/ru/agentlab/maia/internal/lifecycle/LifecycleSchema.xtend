package ru.agentlab.maia.internal.lifecycle

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.lifecycle.ILifecycleSchema
import ru.agentlab.maia.lifecycle.ILifecycleState
import ru.agentlab.maia.lifecycle.ILifecycleTransition

@Accessors
class LifecycleSchema implements ILifecycleSchema {

	val List<ILifecycleState> states = new ArrayList<ILifecycleState>

	val List<ILifecycleTransition> transitions = new ArrayList<ILifecycleTransition>

	ILifecycleState initialState

	ILifecycleState finalState

}