/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.examples;

import java.util.UUID;
import java.util.concurrent.ThreadLocalRandom;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;

import ru.agentlab.maia.FIPAPerformativeNames;
import ru.agentlab.maia.FIPAProtocolNames;
import ru.agentlab.maia.IBeliefBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;
import ru.agentlab.maia.role.AddedMessage;

public abstract class SubscriptionInitiator {

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
		message.setProtocol(FIPAProtocolNames.FIPA_SUBSCRIBE);
		message.setConversationId(conversationId);
		message.setPerformative(FIPAPerformativeNames.SUBSCRIBE);
		messaging.send(message);
	}

	@AddedMessage(performative = FIPAPerformativeNames.AGREE, protocol = FIPAProtocolNames.FIPA_SUBSCRIBE)
	public void onAgree(IMessage message) {
		if (!message.getConversationId().equals(conversationId)) {
			return;
		}
		UUID sender = message.getSender();
		OWLDataFactory factory = beliefBase.getFactory();
		PrefixManager prefixManager = new DefaultPrefixManager();
		prefixManager.setPrefix("maia", "");
		beliefBase.addBelief(
				factory.getOWLObjectPropertyAssertionAxiom(factory.getOWLObjectProperty("this", prefixManager),
						factory.getOWLNamedIndividual("maia:haveSubscription", prefixManager),
						factory.getOWLNamedIndividual(sender.toString(), prefixManager)));
	}

	@AddedMessage(performative = FIPAPerformativeNames.REFUSE, protocol = FIPAProtocolNames.FIPA_SUBSCRIBE)
	public void onRefuse(IMessage message) {
	}

	@AddedMessage(performative = FIPAPerformativeNames.INFORM, protocol = FIPAProtocolNames.FIPA_SUBSCRIBE)
	public void onInform(IMessage message) {
		if (!message.getConversationId().equals(conversationId)) {
			return;
		}
		UUID sender = message.getSender();
		OWLDataFactory factory = beliefBase.getFactory();
		PrefixManager prefixManager = new DefaultPrefixManager();
		prefixManager.setPrefix("maia", "");
		beliefBase.addBelief(
				factory.getOWLObjectPropertyAssertionAxiom(factory.getOWLObjectProperty("this", prefixManager),
						factory.getOWLNamedIndividual("maia:haveSubscription", prefixManager),
						factory.getOWLNamedIndividual(sender.toString(), prefixManager)));
	}

	@PreDestroy
	public void onDestroy() {
		IMessage message = initial;
		message.setProtocol(FIPAProtocolNames.FIPA_SUBSCRIBE);
		message.setConversationId(conversationId);
		message.setPerformative(FIPAPerformativeNames.CANCEL);
		messaging.send(message);
	}

}
