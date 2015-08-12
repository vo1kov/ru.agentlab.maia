package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.execution.action.annotation.Action
import ru.agentlab.maia.execution.action.annotation.Input
import ru.agentlab.maia.execution.action.annotation.Output
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class CreateReplyMessageTask {

	@Input
	IMessage inputMessage

	@Inject
	IMessageFactory messageFactory

	@Action @Output
	def IMessage action() {
		return messageFactory.createReply(inputMessage)
	}

}