package ru.agentlab.maia.messaging.matching

import ru.agentlab.maia.message.IMessage

interface IMessageTemplate {

	def boolean match(IMessage message)

}