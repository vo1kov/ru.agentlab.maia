package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IActionScheme
import ru.agentlab.maia.behaviour.IActionState
import ru.agentlab.maia.behaviour.IActionTransition

@Accessors
abstract class ActionScheme implements IActionScheme {

	val public static STATE_INITIAL = new ActionState("INITIAL")

	val public static STATE_FINAL = new ActionState("FINAL")

	@Inject
	IEclipseContext context

	val List<IActionState> states = new ArrayList<IActionState>

	val List<IActionTransition> transitions = new ArrayList<IActionTransition>

	IActionState initialState

	IActionState finalState

	@PostConstruct
	def void init() {
		states += STATE_INITIAL
		states += STATE_FINAL
	}
	
	override getName() {
		this.class.name
	}

}