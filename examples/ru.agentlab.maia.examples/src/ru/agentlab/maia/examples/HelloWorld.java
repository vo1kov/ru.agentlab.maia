package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IGoalBase;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.messaging.AclMessage;
import ru.agentlab.maia.messaging.IMessageDeliveryService;
import ru.agentlab.maia.role.AddedBelief;
import ru.agentlab.maia.role.AddedGoal;
import ru.agentlab.maia.role.AxiomType;
import ru.agentlab.maia.role.InitialBelief;
import ru.agentlab.maia.role.InitialGoal;

@InitialBelief(value = { ":this", ":havePosition", "_:pos" }, type = AxiomType.OBJECT_PROPERTY_ASSERTION)
@InitialBelief(value = { "_:pos", ":haveX", "2^^xsd:integer" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
@InitialBelief(value = { "_:pos", ":haveY", "2^^xsd:integer" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
@InitialGoal(value = { ":this", ":havePosition", "_:pos" }, type = AxiomType.OBJECT_PROPERTY_ASSERTION)
@InitialGoal(value = { "_:pos", ":haveX", "5^^xsd:integer" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
@InitialGoal(value = { "_:pos", ":haveY", "5^^xsd:integer" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
public class HelloWorld {

	@Inject
	IMessageDeliveryService messaging;

	@PostConstruct
	@AddedBelief(value = { "?some", "hasLength", "value^^xsd:string" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
	public void setup(IGoalBase goalBase) {
	}

	@AddedGoal(value = { "init" }, type = AxiomType.CLASS_ASSERTION)
	@AddedBelief(value = { "?some", "hasLength", "2^^xsd:float" }, type = AxiomType.DATA_PROPERTY_ASSERTION)
	public void onInit() {
		IMessage message = new AclMessage();
		message.setContent("Hello World");
		messaging.send(message);
	}

}
