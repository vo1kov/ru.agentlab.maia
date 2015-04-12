package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import org.maia.task.Action
import org.maia.task.TaskInput
import org.maia.task.TaskOutput
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