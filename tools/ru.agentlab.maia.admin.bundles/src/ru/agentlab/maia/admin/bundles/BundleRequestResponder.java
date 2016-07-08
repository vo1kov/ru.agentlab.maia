package ru.agentlab.maia.admin.bundles;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.FIPAPerformativeNames;
import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;
import ru.agentlab.maia.role.AddedGoal;
import ru.agentlab.maia.role.AddedMessage;
import ru.agentlab.maia.role.AxiomType;
import ru.agentlab.maia.role.FailedGoal;

public class BundleRequestResponder {

	@Inject
	IMessageDeliveryService mts;

	private Map<IGoal, IMessage> requests = new HashMap<>();

	@Inject
	IGoalBase goalBase;

	@AddedMessage(performative = FIPAPerformativeNames.REQUEST, protocol = "FIPA_REQUEST")
	public void onRequest(IMessage message) {
		try {
			IGoal goal = goalBase.addGoal(message.getContent());
			requests.put(goal, message);
			reply(message, FIPAPerformativeNames.AGREE);
		} catch (Exception e) {
			reply(message, FIPAPerformativeNames.REFUSE);
		}
	}

	@AddedMessage(performative = FIPAPerformativeNames.CANCEL, protocol = "FIPA_REQUEST")
	public void onCancel(IMessage message) {
		try {
			goalBase.removeGoal(message.getContent());
			reply(message, FIPAPerformativeNames.INFORM);
		} catch (Exception e) {
			reply(message, FIPAPerformativeNames.FAILURE);
		}
	}

	@AddedGoal(value = "", type = AxiomType.CLASS_ASSERTION)
	public void onGoalFinished(IGoal goal) {
		IMessage message = requests.get(goal);
		if (message != null) {
			reply(message, FIPAPerformativeNames.INFORM);
		}
	}

	@FailedGoal(value = "", type = AxiomType.CLASS_ASSERTION)
	public void onGoalFailed(IGoal goal) {
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
