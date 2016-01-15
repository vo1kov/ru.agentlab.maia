package ru.agentlab.maia.behaviour.scheme.task.lib

import javax.inject.Inject
import ru.agentlab.maia.behaviour.annotation.Execute
import ru.agentlab.maia.behaviour.annotation.Input
import ru.agentlab.maia.behaviour.annotation.Output
import ru.agentlab.maia.messaging.IMessage
import ru.agentlab.maia.messaging.IMessageFactory

class CreateMessageTask {

	@Inject
	IMessageFactory messageFactory

	@Input
	String language

	@Input
	String sender

	@Execute @Output
	def IMessage action() {
		return messageFactory.create => [
			it.language = language
			it.sender = sender
		// TODO: Other fields
		]
	}

}
