package ru.agentlab.maia.messaging.matching

import ru.agentlab.maia.messaging.IMessage

interface IMessageTemplate {

	def boolean match(IMessage message)

}