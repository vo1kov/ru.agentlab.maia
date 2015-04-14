package ru.agentlab.maia.execution.lifecycle.event

import java.util.HashMap
import org.eclipse.xtend.lib.annotations.Accessors
import ru.agentlab.maia.event.IMaiaEvent
import ru.agentlab.maia.execution.lifecycle.IMaiaContextLifecycleState

@Accessors
class LifecycleStateChangeEvent implements IMaiaEvent {

	val static public String KEY_FROM_STATE = "from.state"

	val static public String KEY_TO_STATE = "to.state"

	val String topic = "ru/agentlab/maia/execution/lifecycle/event/StateChange"

	val data = new HashMap<String, Object>

	new(IMaiaContextLifecycleState fromState, IMaiaContextLifecycleState toState) {
		data => [
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

}