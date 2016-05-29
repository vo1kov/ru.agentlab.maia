package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.GoalClassificationAdded;
import ru.agentlab.maia.annotation.InitialBelief;
import ru.agentlab.maia.annotation.InitialGoal;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

@InitialBelief(":this :havePosition :myPosition")
@InitialBelief(":myPosition :haveX 2")
@InitialBelief(":myPosition :haveY 2")
@InitialGoal(":this :havePosition :myPosition")
@InitialGoal(":myPosition :haveX 5")
@InitialGoal(":myPosition :haveY 5")
public class HelloWorld {

	@Inject
	IMessageDeliveryService messaging;

	@Inject
	@PostConstruct
	@BeliefDataPropertyAdded("?some hasLength some string value^^xsd:string")
	public void setup(IGoalBase goalBase) {
	}

	@GoalClassificationAdded("init")
	@BeliefDataPropertyAdded("?some hasLength 2^^xsd:float")
	public void onInit() {
		IMessage message = new AclMessage();
		message.setContent("Hello World");
		messaging.send(message);
	}

}
