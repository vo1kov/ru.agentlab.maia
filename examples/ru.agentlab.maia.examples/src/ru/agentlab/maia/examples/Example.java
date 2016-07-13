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
import ru.agentlab.maia.role.AddedBelief;
import ru.agentlab.maia.role.AddedGoal;
import ru.agentlab.maia.role.AxiomType;
import ru.agentlab.maia.role.FailedGoal;
import ru.agentlab.maia.role.RemovedBelief;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
	@AddedBelief(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@RemovedBelief(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@AddedGoal(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	@FailedGoal(value = { "foaf:Teenager", "foaf:Tomas" }, type = AxiomType.CLASS_ASSERTION)
	public void setup() {
		IPlan plan = new Plan(this, PlanFilterFactory.create(Matchers.anything(), new HashMap<String, Object>()),
				new PlanBodyLambda(() -> {
					System.out.println(service);
					System.out.println(service.hashCode());
				}));
		planBase.add(EventType.ADDED_BELIEF, plan);
	}

}
