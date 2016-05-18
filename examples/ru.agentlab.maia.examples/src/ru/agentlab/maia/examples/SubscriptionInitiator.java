/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.examples;

import static ru.agentlab.maia.IMessage.AGREE;
import static ru.agentlab.maia.IMessage.CANCEL;
import static ru.agentlab.maia.IMessage.INFORM;
import static ru.agentlab.maia.IMessage.REFUSE;
import static ru.agentlab.maia.IMessage.SUBSCRIBE;

import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.inject.Inject;

import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.MessageAdded;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

public abstract class SubscriptionInitiator {

	private static final String PROTOCOL_NAME = "FIPA-SUBSCRIPTION";

	private final static String conversationId = Long.toString(ThreadLocalRandom.current().nextLong());

	@Inject
	private IBeliefBase beliefBase;

	@Inject
	private IMessageDeliveryService messaging;

	private IMessage initial;

	public SubscriptionInitiator(IMessage initial) {
		this.initial = initial;
	}

	@PostConstruct
	public void onSetup() {
		IMessage message = initial;
		message.setProtocol(PROTOCOL_NAME);
		message.setConversationId(conversationId);
		message.setPerformative(SUBSCRIBE);
		messaging.send(message);
	}

	@MessageAdded(performative = AGREE, protocol = PROTOCOL_NAME)
	public void onAgree(IMessage message) {
		if (!message.getConversationId().equals(conversationId)) {
			return;
		}
		UUID sender = message.getSender();
		beliefBase.addObjectPropertyAssertion("this", "maia:haveSubscription", sender.toString());
	}

	@MessageAdded(performative = REFUSE, protocol = PROTOCOL_NAME)
	public void onRefuse(IMessage message) {
	}

	@MessageAdded(performative = INFORM, protocol = PROTOCOL_NAME)
	public void onInform(IMessage message) {
		if (!message.getConversationId().equals(conversationId)) {
			return;
		}
		UUID sender = message.getSender();
		// String content = message.getContent();
		beliefBase.addObjectPropertyAssertion("this", "maia:haveSubscription", sender.toString());
	}

	@PreDestroy
	public void onDestroy() {
		IMessage message = initial;
		message.setProtocol(PROTOCOL_NAME);
		message.setConversationId(conversationId);
		message.setPerformative(CANCEL);
		messaging.send(message);
	}

}
