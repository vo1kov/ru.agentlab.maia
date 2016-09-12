/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.fipa;

import static ru.agentlab.maia.fipa.FIPAPerformativeNames.ACCEPT_PROPOSAL;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.CANCEL;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.CFP;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.INFORM;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.PROPOSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REJECT_PROPOSAL;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_CONTRACT_NET;

import java.util.Collection;
import java.util.Set;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.belief.IBeliefBase;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;
import ru.agentlab.maia.message.impl.AclMessage;

public class FIPAContractNetInitiator {

	@Inject
	private IBeliefBase beliefBase;

	@Inject
	private IMessageDeliveryService messaging;

	@Inject
	private Set<UUID> targetAgents;

	@Inject
	private String template;

	private Collection<IMessage> proposals;

	private State state = State.INITIALIZED;

	private String conversationId;

	public FIPAContractNetInitiator(Set<UUID> targetAgents, String template) {
		this.targetAgents = targetAgents;
		this.template = template;
	}

	@PostConstruct
	public void onSetup(IAgent agent) {
		conversationId = UUID.randomUUID().toString();
		for (UUID targetAgent : targetAgents) {
			IMessage message = new AclMessage();
			message.setSender(agent.getUuid());
			message.setReceiver(targetAgent);
			message.setProtocol(FIPA_CONTRACT_NET);
			message.setConversationId(conversationId);
			message.setPerformative(CFP);
			message.setContent(template);
			messaging.send(message);
		}
		state = State.WAIT_FOR_PROPOSALS;
	}

	@OnMessageReceived(performative = PROPOSE, protocol = FIPA_CONTRACT_NET)
	public void onPropose(IMessage message) {
		if (!checkConversationId(message) && state != State.WAIT_FOR_PROPOSALS) {
			return;
		}
		proposals.add(message);
		if (proposals.size() == targetAgents.size()) {
			estimateProposals();
		}
	}

	@OnMessageReceived(performative = REFUSE, protocol = FIPA_CONTRACT_NET)
	public void onRefuse(IMessage message) {
		if (!checkConversationId(message) && state != State.WAIT_FOR_PROPOSALS) {
			return;
		}
		proposals.add(message);
		if (proposals.size() == targetAgents.size()) {
			estimateProposals();
		}
	}

	@OnMessageReceived(performative = INFORM, protocol = FIPA_CONTRACT_NET)
	public void onInform(IMessage message) {
		if (!checkConversationId(message)) {
			return;
		}
		OWLAxiom axiom = getAxiom(message);
		beliefBase.addBelief(axiom);
	}

	@PreDestroy
	public void onDestroy(IAgent agent) {
		for (UUID targetAgent : targetAgents) {
			IMessage message = new AclMessage();
			message.setSender(agent.getUuid());
			message.setReceiver(targetAgent);
			message.setProtocol(FIPA_CONTRACT_NET);
			message.setConversationId(conversationId);
			message.setPerformative(CANCEL);
			messaging.send(message);
		}
		conversationId = null;
	}

	private void estimateProposals() {
		state = State.ESTIMATE_PROPOSALS;
		UUID minimal = null;
		for (IMessage proposal : proposals) {
			String price = proposal.getContent();
			minimal = proposal.getSender();
		}
		UUID bestGuy = minimal;
		for (IMessage proposal1 : proposals) {
			if (proposal1.getSender() == bestGuy) {
				messaging.reply(proposal1, ACCEPT_PROPOSAL);
			} else {
				messaging.reply(proposal1, REJECT_PROPOSAL);
			}
		}
	}

	private boolean checkConversationId(IMessage message) {
		return message.getConversationId().equals(conversationId);
	}

	private OWLAxiom getAxiom(IMessage message) {
		//
		//
		// TODO: extract belief from message
		//
		//
		return null;
	}

	static enum State {

		INITIALIZED,

		WAIT_FOR_PROPOSALS,

		ESTIMATE_PROPOSALS,

		WAIT_FOR_RESULT,

		FINISHED

	}

}
