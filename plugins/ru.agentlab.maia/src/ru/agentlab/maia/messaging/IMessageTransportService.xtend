package ru.agentlab.maia.messaging

interface IMessageTransportService {

	def void send(IMessage message)
}