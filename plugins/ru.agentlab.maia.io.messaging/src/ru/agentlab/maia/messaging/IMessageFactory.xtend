package ru.agentlab.maia.messaging

interface IMessageFactory  {
	
	def IMessage create()
	
	def IMessage createReply(IMessage message)
}