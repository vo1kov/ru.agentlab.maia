package ru.agentlab.maia.agent.test.doubles;

import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;

public class BeliefAddedDummy {

	@BeliefDataPropertyAdded("")
	public void emptyParameter() {
	}

	@BeliefDataPropertyAdded("one")
	public void onlyOneParameter() {
	}

	@BeliefDataPropertyAdded("one two")
	public void onlyTwoParameter() {
	}

	@BeliefDataPropertyAdded("one two three")
	public void exactlyThreeParameter() {
	}

	@BeliefDataPropertyAdded("?one ?two ?three")
	public void exactlyThreeVariables() {
	}

	@BeliefDataPropertyAdded("?one ?two ?three")
	public void valid() {
	}

}
