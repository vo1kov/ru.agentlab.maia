package ru.agentlab.maia.fipa;

import static ru.agentlab.maia.fipa.FIPAPerformativeNames.AGREE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.CANCEL;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.INFORM;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REQUEST;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_REQUEST;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.agent.annotation.FinalPlan;
import ru.agentlab.maia.goal.IGoalBase;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;

public class FIPARequestResponder {

	@Inject
	private IMessageDeliveryService messaging;

	@Inject
	private IGoalBase goalBase;
	
	IGoalParser parser;

	private final Map<String, OWLAxiom> addedGoals = new HashMap<>();

	@OnMessageReceived(performative = REQUEST, protocol = FIPA_REQUEST)
	public void onRequest(IMessage message) {
		try {
			OWLAxiom goal = parser.parse(message.getContent());
			goalBase.addGoal(goal);
			addedGoals.put(message.getConversationId(), goal);

			messaging.reply(message, AGREE);
		} catch (Exception e) {
			messaging.reply(message, REFUSE);
		}
	}
	
	@FinalPlan
	@OnMessageReceived(performative = CANCEL, protocol = FIPA_REQUEST)
	public void onCancel(IMessage message) {
		OWLAxiom goal = addedGoals.get(message.getConversationId());
		if (goal != null) {
			goalBase.removeGoal(goal);
			messaging.reply(message, INFORM);
		}
	}

}
