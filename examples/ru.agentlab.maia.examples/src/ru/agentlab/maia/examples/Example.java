package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.agent.IPlan;
import ru.agentlab.maia.agent.IPlanBase;
import ru.agentlab.maia.agent.impl.Plan;
import ru.agentlab.maia.belief.annotation.AxiomType;
import ru.agentlab.maia.belief.annotation.OnBeliefAdded;
import ru.agentlab.maia.belief.annotation.OnBeliefRemoved;
import ru.agentlab.maia.belief.event.BeliefAddedEvent;
import ru.agentlab.maia.goal.annotation.OnGoalAdded;
import ru.agentlab.maia.goal.annotation.OnOWLGoalFailed;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@OnBeliefAdded(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnBeliefRemoved(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnGoalAdded(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@OnOWLGoalFailed(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	public void setup() {
		IPlan<BeliefAddedEvent> plan = new Plan<>(BeliefAddedEvent.class, () -> {
			System.out.println(service);
			System.out.println(service.hashCode());
		});
		planBase.add(plan);
	}

}
