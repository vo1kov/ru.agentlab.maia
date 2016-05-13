package ru.agentlab.maia.examples;

import static ru.agentlab.maia.EventType.GOAL_ADDED;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.Trigger;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

public class HelloWorld {

	@Inject
	IMessageDeliveryService messaging;

	@Inject
	IGoalBase goalBase;

	@PostConstruct
	public void setup() {
		goalBase.addGoal("init");
	}

	@Trigger(type = GOAL_ADDED, template = "init")
	public void onSomeClassified() {
		IMessage message = new AclMessage();
		message.setContent("Hello World");
		messaging.send(message);
	}
}
