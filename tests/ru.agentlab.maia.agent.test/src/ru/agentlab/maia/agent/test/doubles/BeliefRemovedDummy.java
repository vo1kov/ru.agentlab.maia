package ru.agentlab.maia.agent.test.doubles;

import ru.agentlab.maia.annotation.BeliefRemoved;

public class BeliefRemovedDummy {

	@BeliefRemoved("")
	public void emptyParameter() {
	}

	@BeliefRemoved("one")
	public void onlyOneParameter() {
	}

	@BeliefRemoved("one two")
	public void onlyTwoParameter() {
	}

	@BeliefRemoved("one two three")
	public void exactlyThreeParameter() {
	}

	@BeliefRemoved("?one ?two ?three")
	public void exactlyThreeVariables() {
	}

}
