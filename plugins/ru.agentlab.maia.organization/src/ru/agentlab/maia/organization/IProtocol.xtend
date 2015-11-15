package ru.agentlab.maia.organization

import java.util.Collection

interface IProtocol {

	def IRole getInitiator()

	def Collection<IProtocolParticipant> getParticipants()

}