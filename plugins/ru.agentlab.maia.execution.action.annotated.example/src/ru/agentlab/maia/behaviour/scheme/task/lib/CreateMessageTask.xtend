package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import org.eclipse.e4.core.di.annotations.Optional
import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.execution.action.annotated.TaskInput
import ru.agentlab.maia.execution.action.annotated.TaskOutput
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class CreateMessageTask {

	@Inject
	IMessageFactory messageFactory

	@TaskInput @Optional
	String language

	@TaskInput @Optional
	String sender

	@Action @TaskOutput
	def IMessage action() {
		return messageFactory.create => [
			it.language = language
			it.sender = sender
		// TODO: Other fields
		]
	}

}