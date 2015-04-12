package ru.agentlab.maia.protocol.lib.internal

import javax.annotation.PostConstruct
import ru.agentlab.maia.protocol.IProtocolRole
import ru.agentlab.maia.protocol.IProtocolRole.Cardinality
import ru.agentlab.maia.protocol.internal.Protocol
import ru.agentlab.maia.protocol.internal.ProtocolRole

class FipaContractNetProtorcol extends Protocol {

	val static IProtocolRole ROLE_INTIATOR = new ProtocolRole("INTIATOR", null, Cardinality.SINGLE)

	val static IProtocolRole ROLE_RESPONDER = new ProtocolRole("RESPONDER", null, Cardinality.MULTIPLE)

	@PostConstruct
	def void init() {
		roles += ROLE_INTIATOR
		roles += ROLE_RESPONDER
	}

}