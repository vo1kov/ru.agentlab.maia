package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	public void setup() {
		IPlan plan = planBase.createPlan(this, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(EventType.BELIEF_CLASSIFICATION_ADDED, plan);
	}

}
