package ru.agentlab.maia.internal.lifecycle

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.lifecycle.ILifecycleScheme
import ru.agentlab.maia.lifecycle.ILifecycleState
import ru.agentlab.maia.lifecycle.ILifecycleTransition

@Accessors
class LifecycleScheme implements ILifecycleScheme {

	val List<ILifecycleState> states = new ArrayList<ILifecycleState>

	val List<ILifecycleTransition> transitions = new ArrayList<ILifecycleTransition>

	ILifecycleState initialState

	ILifecycleState finalState

}