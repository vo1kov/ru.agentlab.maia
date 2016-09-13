package ru.agentlab.maia.fipa;

import static ru.agentlab.maia.fipa.FIPAPerformativeNames.SUBSCRIBE;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_SUBSCRIBE;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.impl.AclMessage;

public class FIPACancelInitiator {

	@Inject
	private IMessageDeliveryService messaging;

	@PostConstruct
	public void onSetup(String conversationId) {
		IMessage message = new AclMessage();
		message.setProtocol(FIPA_SUBSCRIBE);
		message.setConversationId(conversationId);
		message.setPerformative(SUBSCRIBE);
		messaging.send(message);
	}

}
