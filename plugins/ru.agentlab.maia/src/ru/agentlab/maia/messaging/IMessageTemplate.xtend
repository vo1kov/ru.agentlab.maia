package ru.agentlab.maia.messaging

interface IMessageTemplate {
	
	def boolean match(IMessage message)
	
}