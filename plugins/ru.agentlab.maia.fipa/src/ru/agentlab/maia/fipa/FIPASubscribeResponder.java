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
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.SUBSCRIBE;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_SUBSCRIBE;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;

public class FIPASubscribeResponder {

	@Inject
	private IPlanBase planBase;

	@Inject
	private IMessageDeliveryService messaging;

	private final Map<String, IPlan<?>> addedPlans = new HashMap<>();

	@OnMessageReceived(performative = SUBSCRIBE, protocol = FIPA_SUBSCRIBE)
	public void onSubscribe(IMessage message) {
		try {
			IPlan<?> plan = getPlan(message);
			addedPlans.put(message.getConversationId(), plan);
			planBase.add(plan);

			messaging.reply(message, AGREE);
		} catch (Exception e) {
			messaging.reply(message, REFUSE);
		}
	}

	@OnMessageReceived(performative = CANCEL, protocol = FIPA_SUBSCRIBE)
	public void onCancel(IMessage message) {
		IPlan<?> plan = addedPlans.get(message.getConversationId());
		if (plan != null) {
			planBase.remove(plan);
			messaging.reply(message, INFORM);
		}
	}

	private IPlan<?> getPlan(IMessage message) {
		//
		//
		// TODO: extract template from message
		//
		//
		IPlan<Object> plan = new Plan<>(Object.class, () -> {
			messaging.reply(message, INFORM);
		});
		return plan;
	}

}
