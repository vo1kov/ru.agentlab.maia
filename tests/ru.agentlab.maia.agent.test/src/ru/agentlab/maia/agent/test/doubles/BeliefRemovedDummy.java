package ru.agentlab.maia.agent.test.doubles;

import ru.agentlab.maia.annotation.BeliefDataPropertyRemoved;

public class BeliefRemovedDummy {

	@BeliefDataPropertyRemoved("")
	public void emptyParameter() {
	}

	@BeliefDataPropertyRemoved("one")
	public void onlyOneParameter() {
	}

	@BeliefDataPropertyRemoved("one two")
	public void onlyTwoParameter() {
	}

	@BeliefDataPropertyRemoved("one two three")
	public void exactlyThreeParameter() {
	}

	@BeliefDataPropertyRemoved("?one ?two ?three")
	public void exactlyThreeVariables() {
	}

}
