package ru.agentlab.maia.service.message.fipa;

import java.util.Queue;
import java.util.UUID;
import java.util.concurrent.ScheduledExecutorService;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLIndividualAxiom;

import ru.agentlab.maia.IContainer;
import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.IRole;
import ru.agentlab.maia.service.message.IMessageDeliveryService;

public class AbstractResponder {

	protected final UUID conversationId = UUID.randomUUID();

	@Inject
	protected IMessageDeliveryService messaging;

	@Inject
	protected IGoalBase goalBase;

	@Inject
	protected Queue<Object> eventQueue;

	@Inject
	protected IRole role;

	@Inject
	protected ScheduledExecutorService scheduler;

	@Inject
	protected IContainer container;

	protected IAgentFilter filter = new AllowAllAgentFilter();

	protected void addGoal(Object event) {
//		goalBase.add(event);
	}

	protected void addEvent(Object event) {
		eventQueue.offer(event);
	}

	protected IBeliefParser getBeliefParser(String language) {
		// if (language != null) {
		// return (IBeliefParser) container.get(language);
		// } else {
		// return container.get(IBeliefParser.class);
		// }
		return new IBeliefParser() {

			@Override
			public OWLAxiom parse(String content) {
				return null;
			}
		};
	}

	protected IGoalParser getGoalParser(String language) {
		// if (language != null) {
		// return (IGoalParser) container.get(language);
		// } else {
		// return container.get(IGoalParser.class);
		// }
		return new IGoalParser() {

			@Override
			public OWLIndividualAxiom parse(String content) {
				return null;
//				return new IGoal() {
//
//				};
			}
		};
	}

	protected void reply(IMessage message, String performative) {
		messaging.reply(message, performative);
	}

	protected void reply(IMessage message, String performative, String content) {
		messaging.reply(message, performative, content);
	}
}