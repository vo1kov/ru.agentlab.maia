package ru.agentlab.maia.admin.bundles;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.belief.annotation.AxiomType;
import ru.agentlab.maia.fipa.FIPAPerformativeNames;
import ru.agentlab.maia.goal.IGoalBase;
import ru.agentlab.maia.goal.annotation.OnGoalAdded;
import ru.agentlab.maia.goal.annotation.OnOWLGoalFailed;
import ru.agentlab.maia.message.IMessageDeliveryService;
import ru.agentlab.maia.message.annotation.OnMessageReceived;

public class BundleRequestResponder {

	@Inject
	IMessageDeliveryService mts;

	private Map<OWLAxiom, IMessage> requests = new HashMap<>();

	@Inject
	IGoalBase goalBase;

	@OnMessageReceived(performative = FIPAPerformativeNames.REQUEST, protocol = "FIPA_REQUEST")
	public void onRequest(IMessage message) {
		try {
			OWLAxiom goal = goalBase.addGoal(message.getContent());
			requests.put(goal, message);
			reply(message, FIPAPerformativeNames.AGREE);
		} catch (Exception e) {
			reply(message, FIPAPerformativeNames.REFUSE);
		}
	}

	@OnMessageReceived(performative = FIPAPerformativeNames.CANCEL, protocol = "FIPA_REQUEST")
	public void onCancel(IMessage message) {
		try {
			goalBase.removeGoal(message.getContent());
			reply(message, FIPAPerformativeNames.INFORM);
		} catch (Exception e) {
			reply(message, FIPAPerformativeNames.FAILURE);
		}
	}

	@OnGoalAdded(value = "", type = AxiomType.CLASS_ASSERTION)
	public void onGoalFinished(OWLAxiom goal) {
		IMessage message = requests.get(goal);
		if (message != null) {
			reply(message, FIPAPerformativeNames.INFORM);
		}
	}

	@OnOWLGoalFailed(value = "", type = AxiomType.CLASS_ASSERTION)
	public void onGoalFailed(OWLAxiom goal) {
		IMessage message = requests.get(goal);
		if (message != null) {
			reply(message, FIPAPerformativeNames.FAILURE);
		}
	}

	private void reply(IMessage message, String performative) {
		IMessage reply = message.createReply();
		reply.setPerformative(performative);
		mts.send(reply);
	}

}
