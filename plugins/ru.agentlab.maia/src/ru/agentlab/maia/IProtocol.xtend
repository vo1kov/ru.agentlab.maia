package ru.agentlab.maia

import java.util.Collection

interface IProtocol {

	def IRole getInitiator()

	def Collection<IProtocolParticipant> getParticipants()

}