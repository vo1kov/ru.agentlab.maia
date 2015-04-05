package ru.agentlab.maia.internal.protocol.fipa

import javax.annotation.PostConstruct
import ru.agentlab.maia.internal.protocol.Protocol
import ru.agentlab.maia.internal.protocol.ProtocolRole
import ru.agentlab.maia.protocol.IProtocolRole
import ru.agentlab.maia.protocol.IProtocolRole.Cardinality

class FipaRequestProtorcol extends Protocol {

	val static IProtocolRole ROLE_INTIATOR = new ProtocolRole("INTIATOR", null, Cardinality.SINGLE)

	val static IProtocolRole ROLE_RESPONDER = new ProtocolRole("RESPONDER", null, Cardinality.SINGLE)

	@PostConstruct
	def void init() {
		roles += ROLE_INTIATOR
		roles += ROLE_RESPONDER
	}

}