package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.annotation.trigger.AddedBeliefClassAssertionAxiom;
import ru.agentlab.maia.agent.annotation.trigger.AddedGoalClassAssertionAxiom;
import ru.agentlab.maia.agent.annotation.trigger.FailedGoalClassAssertionAxiom;
import ru.agentlab.maia.agent.annotation.trigger.RemovedBeliefClassAssertionAxiom;
import ru.agentlab.maia.agent.annotation.trigger.RemovedGoalClassAssertionAxiom;
import ru.agentlab.maia.agent.event.BeliefAddedEvent;
import ru.agentlab.maia.agent.impl.Plan;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@AddedBeliefClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	@RemovedBeliefClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	@AddedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	@FailedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	@RemovedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	public void setup() {
		IPlan<BeliefAddedEvent> plan = new Plan<>(BeliefAddedEvent.class, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(plan);
	}

}
