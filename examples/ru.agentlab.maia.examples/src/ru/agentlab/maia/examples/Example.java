package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.annotation.event.AddedClassAssertion;
import ru.agentlab.maia.annotation.event.FailedClassAssertion;
import ru.agentlab.maia.annotation.event.GoalClassAssertion;
import ru.agentlab.maia.annotation.event.RemovedClassAssertion;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@AddedClassAssertion(clazz = "foaf:Teenager", individual = "foaf:Tomas")
	@RemovedClassAssertion(clazz = "foaf:Teenager", individual = "foaf:Tomas")
	@GoalClassAssertion(clazz = "foaf:Teenager", individual = "foaf:Tomas")
	@FailedClassAssertion(clazz = "foaf:Teenager", individual = "foaf:Tomas")
	public void setup() {
		IPlan plan = planBase.createPlan(this, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(EventType.BELIEF_CLASSIFICATION_ADDED, plan);
	}

}
