package ru.agentlab.maia.messaging.matching

import ru.agentlab.maia.IMessage

interface IMessageTemplate {

	def boolean match(IMessage message)

}