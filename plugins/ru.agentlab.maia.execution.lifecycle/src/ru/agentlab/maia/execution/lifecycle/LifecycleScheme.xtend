package ru.agentlab.maia.execution.lifecycle

import java.util.ArrayList
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class LifecycleScheme implements IMaiaContextLifecycleScheme {

	val List<IMaiaContextLifecycleState> states = new ArrayList<IMaiaContextLifecycleState>

	val List<IMaiaContextLifecycleTransition> transitions = new ArrayList<IMaiaContextLifecycleTransition>

	IMaiaContextLifecycleState initialState

	IMaiaContextLifecycleState finalState

}