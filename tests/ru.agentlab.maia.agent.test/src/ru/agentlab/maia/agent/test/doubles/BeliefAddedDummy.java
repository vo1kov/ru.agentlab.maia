package ru.agentlab.maia.agent.test.doubles;

import ru.agentlab.maia.annotation.BeliefAdded;

public class BeliefAddedDummy {

	@BeliefAdded("")
	public void emptyParameter() {
	}

	@BeliefAdded("one")
	public void onlyOneParameter() {
	}

	@BeliefAdded("one two")
	public void onlyTwoParameter() {
	}

	@BeliefAdded("one two three")
	public void exactlyThreeParameter() {
	}

	@BeliefAdded("?one ?two ?three")
	public void exactlyThreeVariables() {
	}

	@BeliefAdded("?one ?two ?three")
	public void valid() {
	}

}
