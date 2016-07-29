package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.agent.belief.BeliefAddedEvent;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.plan.IPlan;
import ru.agentlab.maia.plan.IPlanBase;

public class ExampleLambdaPlan {

	@Inject
	IPlanBase planBase;

	@Inject
	Object service;

	@PostConstruct
	public void setup() {
		IPlan plan = new Plan(this, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(BeliefAddedEvent.class, plan);
	}

}
