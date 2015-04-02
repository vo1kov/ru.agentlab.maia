package ru.agentlab.maia.internal.lifecycle.scheme

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.lifecycle.scheme.ILifecycleScheme
import ru.agentlab.maia.lifecycle.scheme.ILifecycleState
import ru.agentlab.maia.lifecycle.scheme.ILifecycleTransition

@Accessors
class LifecycleScheme implements ILifecycleScheme {

	val List<ILifecycleState> states = new ArrayList<ILifecycleState>

	val List<ILifecycleTransition> transitions = new ArrayList<ILifecycleTransition>

	ILifecycleState initialState

	ILifecycleState finalState

}