package ru.agentlab.maia.execution.lifecycle.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleState
import ru.agentlab.maia.context.IMaiaContext

@Accessors
class MaiaLifecycleStateChangeEvent implements IMaiaEvent {
	
	val static protected String KEY_CONTEXT = "context"

	val static protected String KEY_FROM_STATE = "from.state"

	val static protected String KEY_TO_STATE = "to.state"

	val public static String TOPIC = "ru/agentlab/maia/execution/lifecycle/event/StateChange"

	val data = new HashMap<String, Object>

	new(IMaiaContext context, IMaiaContextLifecycleState fromState, IMaiaContextLifecycleState toState) {
		data => [
			put(KEY_CONTEXT, context)
			put(KEY_FROM_STATE, fromState)
			put(KEY_TO_STATE, toState)
		]
	}

	def IMaiaContextLifecycleState getFromState() {
		return data.get(KEY_FROM_STATE) as IMaiaContextLifecycleState
	}

	def IMaiaContextLifecycleState getToState() {
		return data.get(KEY_TO_STATE) as IMaiaContextLifecycleState
	}

	def IMaiaContext getContext() {
		return data.get(KEY_CONTEXT) as IMaiaContext
	}
	
	override getTopic() {
		return TOPIC
	}

}