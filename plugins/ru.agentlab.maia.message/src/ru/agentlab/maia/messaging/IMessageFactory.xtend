package ru.agentlab.maia.messaging

import ru.agentlab.maia.message.IMessage

interface IMessageFactory  {
	
	def IMessage create()
	
	def IMessage createReply(IMessage message)
}