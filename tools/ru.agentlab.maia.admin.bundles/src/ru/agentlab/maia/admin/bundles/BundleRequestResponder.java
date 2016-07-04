package ru.agentlab.maia.admin.bundles;

import static ru.agentlab.maia.IMessage.AGREE;
import static ru.agentlab.maia.IMessage.CANCEL;
import static ru.agentlab.maia.IMessage.FAILURE;
import static ru.agentlab.maia.IMessage.INFORM;
import static ru.agentlab.maia.IMessage.REFUSE;
import static ru.agentlab.maia.IMessage.REQUEST;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import ru.agentlab.maia.IGoal;
import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.GoalClassificationFailed;
import ru.agentlab.maia.annotation.GoalClassificationFinished;
import ru.agentlab.maia.annotation.event.AddedMessage;
import ru.agentlab.maia.annotation2.AxiomType;
import ru.agentlab.maia.annotation2.FailedGoal;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

public class BundleRequestResponder {

	@Inject
	IMessageDeliveryService mts;

	private Map<IGoal, IMessage> requests = new HashMap<>();

	@Inject
	IGoalBase goalBase;

	@AddedMessage(performative = REQUEST, protocol = "FIPA_REQUEST")
	public void onRequest(IMessage message) {
		try {
			IGoal goal = goalBase.addGoal(message.getContent());
			requests.put(goal, message);
			reply(message, AGREE);
		} catch (Exception e) {
			reply(message, REFUSE);
		}
	}

	@AddedMessage(performative = CANCEL, protocol = "FIPA_REQUEST")
	public void onCancel(IMessage message) {
		try {
			goalBase.removeGoal(message.getContent());
			reply(message, INFORM);
		} catch (Exception e) {
			reply(message, FAILURE);
		}
	}

	@AddedGoalClassificationFinished("")
	public void onGoalFinished(IGoal goal) {
		IMessage message = requests.get(goal);
		if (message != null) {
			reply(message, INFORM);
		}
	}

	@FailedGoal(value = "", type = AxiomType.CLASS_ASSERTION)
	public void onGoalFailed(IGoal goal) {
		IMessage message = requests.get(goal);
		if (message != null) {
			reply(message, FAILURE);
		}
	}

	private void reply(IMessage message, String performative) {
		IMessage reply = message.createReply();
		reply.setPerformative(performative);
		mts.send(reply);
	}

}
