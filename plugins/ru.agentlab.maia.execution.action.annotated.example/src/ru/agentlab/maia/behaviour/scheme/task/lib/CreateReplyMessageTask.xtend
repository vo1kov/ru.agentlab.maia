package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotated.Action
import ru.agentlab.maia.execution.action.annotated.TaskInput
import ru.agentlab.maia.execution.action.annotated.TaskOutput
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class CreateReplyMessageTask {

	@TaskInput
	IMessage inputMessage

	@Inject
	IMessageFactory messageFactory

	@Action @TaskOutput
	def IMessage action() {
		return messageFactory.createReply(inputMessage)
	}

}