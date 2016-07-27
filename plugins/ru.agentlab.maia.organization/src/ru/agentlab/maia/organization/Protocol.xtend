package ru.agentlab.maia.organization

import java.util.Collection
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Protocol implements IProtocol {

	var IRole initiator

	var Collection<IProtocolParticipant> participants

	var String ontology

	var String language

	var String label

}