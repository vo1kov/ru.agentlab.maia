package ru.agentlab.maia.examples;

import java.util.HashMap;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import org.hamcrest.Matchers;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.PlanBodyLambda;
import ru.agentlab.maia.agent.PlanFilterFactory;

public class ExampleLambdaPlan {

	@Inject
	IPlanBase planBase;

	@Inject
	Object service;

	@PostConstruct
	public void setup() {
		IPlan plan = new Plan(this, PlanFilterFactory.create(Matchers.anything(), new HashMap<String, Object>()),
				new PlanBodyLambda(() -> {
					System.out.println(service);
					System.out.println(service.hashCode());
				}));
		planBase.add(EventType.ADDED_BELIEF, plan);
	}

}
