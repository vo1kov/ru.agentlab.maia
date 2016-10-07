package ru.agentlab.maia.fipa;

import static ru.agentlab.maia.fipa.FIPAPerformativeNames.AGREE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.CANCEL;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.FAILURE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.INFORM;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.NOT_UNDERSTOOD;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REFUSE;
import static ru.agentlab.maia.fipa.FIPAPerformativeNames.REQUEST;
import static ru.agentlab.maia.fipa.FIPAProtocolNames.FIPA_REQUEST;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.annotation.PreDestroy;

import ru.agentlab.maia.agent.IMessage;
import ru.agentlab.maia.goal.IGoal;
import ru.agentlab.maia.message.annotation.OnMessageReceived;
import ru.agentlab.maia.message.impl.AclMessage;
import ru.agentlab.maia.time.annotation.OnTimerDelay;

public class FIPARequestResponder extends AbstractResponder {

	private final Map<IMessage, IGoal> addedGoals = new HashMap<>();

	@OnMessageReceived
	public void onMessage(AclMessage message) {
		if (isNotMyMessage(message)) {
			return;
		}
		if (!filter.match(message.getSender())) {
			reply(message, REFUSE);
			return;
		}
		switch (message.getPerformative()) {
		case REQUEST:
			String lang = message.getLanguage();
			IGoalParser parser = getGoalParser(lang);
			if (parser == null) {
				reply(message, NOT_UNDERSTOOD, "Unknown language [" + lang + "]");
				return;
			}
			try {
				IGoal goal = parser.parse(message.getContent());
				goalBase.addGoal(goal);
				addedGoals.put(message, goal);
				reply(message, AGREE);
			} catch (Exception e) {
				reply(message, NOT_UNDERSTOOD, "Exception was thrown " + e.getClass() + " " + e.getMessage());
			}
			return;
		case NOT_UNDERSTOOD:
		case CANCEL:
			IGoal goal = addedGoals.get(message);
			if (goal != null) {
				goalBase.removeGoal(goal);
			}
			return;
		}
	}

	@PreDestroy
	public void onDestroy() {
		addedGoals.forEach((message, goal) -> {
			goalBase.removeGoal(goal);
			reply(message, FAILURE, "Destroing role.. Bye..");
		});
	}

	@OnTimerDelay(value = 2, unit = TimeUnit.SECONDS)
	public void onGoalSuccess() {
		IMessage message = addedGoals.keySet().iterator().next();
		reply(message, INFORM);
	}

	public void onGoalFailed(IGoal goal) {

	}

	private boolean isNotMyMessage(AclMessage message) {
		return !message.checkProtocol(FIPA_REQUEST);
	}

}
