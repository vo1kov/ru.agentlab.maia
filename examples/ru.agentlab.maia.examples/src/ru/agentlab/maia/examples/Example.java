package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.belief.annotation.AxiomType;
import ru.agentlab.maia.agent.belief.annotation.OnBeliefAdded;
import ru.agentlab.maia.agent.belief.annotation.OnBeliefRemoved;
import ru.agentlab.maia.agent.goal.annotation.OnGoalAdded;
import ru.agentlab.maia.agent.goal.annotation.OnGoalFailed;
import ru.agentlab.maia.event.BeliefAddedEvent;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@OnBeliefAdded(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnBeliefRemoved(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnGoalAdded(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnGoalFailed(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	public void setup() {
		IPlan plan = new Plan(this, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(BeliefAddedEvent.class, plan);
	}

}
