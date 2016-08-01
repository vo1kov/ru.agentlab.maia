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
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.FAILURE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.INFORM;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.SUBSCRIBE;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_SUBSCRIBE;

import java.util.Collection;
import java.util.Collections;

import javax.inject.Inject;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.belief.event.BeliefAddedEvent;
import ru.agentlab.maia.message.IMessage;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;

public class FIPASubscribeResponder {

	private final Multimap<String, IPlan> addedPlans = ArrayListMultimap.create();

	@Inject
	private IPlanBase planBase;

	@Inject
	private IMessageDeliveryService messaging;

	@OnMessageReceived(performative = SUBSCRIBE, protocol = FIPA_SUBSCRIBE)
	public void onSubscribe(IMessage message) {
		try {
			Collection<IPlan> plans = getPlans(message);
			addedPlans.putAll(message.getConversationId(), plans);
			planBase.addAll(BeliefAddedEvent.class, plans);

			messaging.reply(message, AGREE);
		} catch (Exception e) {
			messaging.reply(message, REFUSE);
		}
	}

	@OnMessageReceived(performative = CANCEL, protocol = FIPA_SUBSCRIBE)
	public void onCancel(IMessage message) {
		Collection<IPlan> plans = addedPlans.get(message.getConversationId());
		if (!plans.isEmpty()) {
			for (IPlan plan : plans) {
				planBase.remove(BeliefAddedEvent.class, plan);
			}
			messaging.reply(message, INFORM);
		} else {
			messaging.reply(message, FAILURE);
		}
	}

	private Collection<IPlan> getPlans(IMessage message) {
		//
		//
		// TODO: extract template from message
		//
		//
		IPlan plan = new Plan(this, () -> {
			messaging.reply(message, INFORM);
		});
		return Collections.singleton(plan);
	}

}
