package ru.agentlab.maia.examples;

import javax.annotation.PostConstruct;
import javax.inject.Inject;

import ru.agentlab.maia.IPlanBase;

public class Example {

	@Inject
	IPlanBase planBase;

	@Inject
	String service;

	@PostConstruct
    //@AddedBeliefClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
    //@RemovedBeliefClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
    //@AddedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
    //@FailedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
    //@RemovedGoalClassAssertionAxiom({ "foaf:Teenager", "foaf:Tomas" })
	public void setup() {
        System.out.println("PLAN ADDED"); //$NON-NLS-1$
	}

}
