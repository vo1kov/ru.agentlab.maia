package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionState
import ru.agentlab.maia.behaviour.IActionTransition
import ru.agentlab.maia.behaviour.IActionScheme

@Accessors
class ActionScheme implements IActionScheme {

	@Inject
	IEclipseContext context

	val List<IActionState> states = new ArrayList<IActionState>

	val List<IActionTransition> transitions = new ArrayList<IActionTransition>

	IActionState initialState

	IActionState finalState

}