package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.annotation.event.AddedDataPropertyAssertion;
import ru.agentlab.maia.annotation.event.GoalClassAssertion;
import ru.agentlab.maia.annotation.initial.InitialDataPropertyAssertion;
import ru.agentlab.maia.annotation.initial.InitialObjectPropertyAssertion;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;

@InitialObjectPropertyAssertion({ ":this :havePosition _:pos", "zxc" })
@InitialDataPropertyAssertion({ "_:pos :haveX 2", "_:pos :haveY 2" })
// @InitialDataPropertyAssertion("_:pos :haveY 2")
// @InitialGoal(":this :havePosition :myPosition")
// @InitialGoal(":myPosition :haveX 5")
// @InitialGoal(":myPosition :haveY 5")
public class HelloWorld {

	@Inject
	IMessageDeliveryService messaging;

	@Inject
	@PostConstruct
	@AddedDataPropertyAssertion("?some hasLength some string value^^xsd:string")
	public void setup(IGoalBase goalBase) {
	}

	@GoalClassAssertion("init")
	@AddedDataPropertyAssertion("?some hasLength 2^^xsd:float")
	public void onInit() {
		IMessage message = new AclMessage();
		message.setContent("Hello World");
		messaging.send(message);
	}

}
