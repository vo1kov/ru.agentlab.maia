package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.GoalAdded;
import ru.agentlab.maia.annotation.Optional;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

@Optional
public class HelloWorld {

	@Inject
	IMessageDeliveryService messaging;

	@Inject
	@PostConstruct
	public void setup(IGoalBase goalBase) {
		goalBase.addGoal("init");
	}

	@GoalAdded("init")
	public void onInit() {
		IMessage message = new AclMessage();
		message.setContent("Hello World");
		messaging.send(message);
	}

}
