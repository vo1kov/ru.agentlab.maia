package ru.agentlab.maia.behaviour.task

import javax.inject.Inject
import ru.agentlab.maia.Action
import ru.agentlab.maia.TaskInput
import ru.agentlab.maia.TaskOutput
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