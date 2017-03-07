package ru.agentlab.maia.service.message.fipa;

import static ru.agentlab.maia.service.message.fipa.FIPAPerformativeNames.SUBSCRIBE;
import static ru.agentlab.maia.service.message.fipa.FIPAProtocolNames.FIPA_SUBSCRIBE;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.service.message.IMessageDeliveryService;
import ru.agentlab.maia.service.message.impl.AclMessage;

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
