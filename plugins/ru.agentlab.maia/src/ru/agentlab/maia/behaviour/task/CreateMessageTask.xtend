package ru.agentlab.maia.behaviour.task

import javax.inject.Inject
import org.eclipse.e4.core.di.annotations.Optional
import ru.agentlab.maia.Action
import ru.agentlab.maia.TaskInput
import ru.agentlab.maia.TaskOutput
import ru.agentlab.maia.agent.IAgentId
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class CreateMessageTask {

	@Inject
	IMessageFactory messageFactory

	@TaskInput @Optional
	String language

	@TaskInput @Optional
	IAgentId sender

	@Action @TaskOutput
	def IMessage action() {
		return messageFactory.create => [
			it.language = language
			it.sender = sender
		// TODO: Other fields
		]
	}

}