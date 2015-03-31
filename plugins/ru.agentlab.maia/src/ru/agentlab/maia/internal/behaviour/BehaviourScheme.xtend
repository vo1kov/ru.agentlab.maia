package ru.agentlab.maia.internal.behaviour

import java.util.ArrayList
import java.util.List
import javax.annotation.PostConstruct
import javax.inject.Inject
import org.eclipse.e4.core.contexts.IEclipseContext
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.behaviour.IBehaviourScheme
import ru.agentlab.maia.behaviour.IBehaviourState
import ru.agentlab.maia.behaviour.IBehaviourTransition

@Accessors
abstract class BehaviourScheme implements IBehaviourScheme {

	val public static STATE_INITIAL = new BehaviourState("INITIAL")

	val public static STATE_FINAL = new BehaviourState("FINAL")

	@Inject
	IEclipseContext context

	val List<IBehaviourState> states = new ArrayList<IBehaviourState>

	val List<IBehaviourTransition> transitions = new ArrayList<IBehaviourTransition>

	IBehaviourState initialState

	IBehaviourState finalState

	@PostConstruct
	def void init() {
		states += STATE_INITIAL
		states += STATE_FINAL
	}
	
	override getName() {
		this.class.name
	}

}