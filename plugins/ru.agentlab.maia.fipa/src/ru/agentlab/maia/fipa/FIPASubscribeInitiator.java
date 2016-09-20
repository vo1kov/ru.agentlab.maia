/*******************************************************************************
 * Copyright (c) 2016 AgentLab.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *******************************************************************************/
package ru.agentlab.maia.fipa;

import static ru.agentlab.maia.fipa.FIPAPerformativeNames.AGREE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.CANCEL;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.INFORM;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.NOT_UNDERSTOOD;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.SUBSCRIBE;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_SUBSCRIBE;

import java.util.UUID;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.belief.IBeliefBase;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;
import ru.agentlab.maia.message.impl.AclMessage;

/**
 * 
 * <pre>
 *                  Initiator                 Responder
 *                      |                         |
 *                 +----------+                   |
 *                 | onSetup  |-----SUBSCRIBE---->|
 *                 +----------+                   |
 *                      |                         |
 *                 +----------+                   |
 * [exception] <---| onNotUnd |<--NOT_UNDERSTOOD  |
 *                 +----------+                \  |
 *                      |                       \ |
 *                 +----------+                  \|
 * [exception] <---| onRefuse |<------REFUSE------|
 *                 +----------+                  /|
 *                      |                       / |
 *                 +----------+                /  |
 *                 | onAgree  |<-------AGREE--/   |
 *                 +----------+                   |
 *                      |                         |
 *                 +----------+                   |
 *    [result] <---| onInform |<------INFORM------|
 *       xN        +----------+         xN        |
 *                      |                         |
 *                      |                         |
 * </pre>
 * 
 * @see <a href="http://www.fipa.org/specs/fipa00035/SC00035H.html">FIPA
 *      Subscribe Interaction Protocol Specification</a>
 * @see ru.agentlab.maia.fipa.FIPASubscribeResponder
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class FIPASubscribeInitiator {

	private final String conversationId = UUID.randomUUID().toString();

	@Inject
	private IBeliefBase beliefBase;

	@Inject
	private IMessageDeliveryService messaging;

	@Inject
	private UUID targetAgent;

	@Inject
	private String template;

	@Inject
	private IBeliefParser parser;

	@OnRoleActivated
	public void onRoleActivated(IAgent agent) {
		messaging.send(createMessageToTargetAgent(agent, SUBSCRIBE, template));
	}

	@OnMessageReceived(performative = AGREE, protocol = FIPA_SUBSCRIBE)
	public void onAgree(IMessage message) {
		if (!checkConversationId(message)) {
			// Do nothing
			return;
		}
	}

	@OnMessageReceived(performative = NOT_UNDERSTOOD, protocol = FIPA_SUBSCRIBE)
	public void onNotUnderstood(IMessage message) {
		if (checkConversationId(message)) {
			throw new NotUnderstoodException();
		}
	}

	@OnMessageReceived(performative = REFUSE, protocol = FIPA_SUBSCRIBE)
	public void onRefuse(IMessage message) {
		if (checkConversationId(message)) {
			throw new RefuseException();
		}
	}

	@OnMessageReceived(performative = INFORM, protocol = FIPA_SUBSCRIBE)
	public void onInform(IMessage message) {
		if (checkConversationId(message)) {
			OWLAxiom axiom = parser.parse(message.getContent());
			beliefBase.addBelief(axiom);
		}
	}

	@OnRoleDeactivated
	public void onRoleDeactivated(IAgent agent) {
		messaging.send(createMessageToTargetAgent(agent, CANCEL));
	}

	private IMessage createMessageToTargetAgent(IAgent agent, String performative) {
		IMessage message = new AclMessage();
		message.setSender(agent.getUuid());
		message.setReceiver(targetAgent);
		message.setProtocol(FIPA_SUBSCRIBE);
		message.setPerformative(performative);
		message.setConversationId(conversationId);
		return message;
	}

	private IMessage createMessageToTargetAgent(IAgent agent, String performative, String content) {
		IMessage message = createMessageToTargetAgent(agent, performative);
		message.setContent(content);
		return message;
	}

	private boolean checkConversationId(IMessage message) {
		return message.getConversationId().equals(conversationId);
	}

}
