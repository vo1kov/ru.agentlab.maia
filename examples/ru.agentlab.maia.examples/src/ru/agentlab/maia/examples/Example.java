package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.annotation.ext.AddedClassAssertion;
import ru.agentlab.maia.annotation.ext.FailedClassAssertion;
import ru.agentlab.maia.annotation.ext.GoalClassAssertion;
import ru.agentlab.maia.annotation.ext.RemovedClassAssertion;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@AddedClassAssertion("a:Teenager a:Tomas") // The same as Agentspeak +
	@RemovedClassAssertion("a:Teenager a:Tomas") // The same as Agentspeak -
	@GoalClassAssertion("a:Teenager a:Tomas") // The same as Agentspeak +!
	@FailedClassAssertion("a:Some a:Test") // The same as Agentspeak -!
	public void setup() {
		IPlan plan = planBase.createPlan(this, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(EventType.BELIEF_CLASSIFICATION_ADDED, plan);
	}

}
