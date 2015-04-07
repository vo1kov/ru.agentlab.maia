package org.maia.messaging

interface IMessageFactory  {
	
	def IMessage create()
	
	def IMessage createReply(IMessage message)
}