package ru.agentlab.maia.agent.factory;

import ru.agentlab.maia.agent.IAgent;
import ru.agentlab.maia.agent.IBeliefBase;
import ru.agentlab.maia.agent.IGoalBase;
import ru.agentlab.maia.agent.impl.Agent;
import ru.agentlab.maia.agent.impl.BeliefBase;
import ru.agentlab.maia.agent.impl.GoalBase;

public class Agents {

	public static IAgent createEmpty() {
		return new Agent();
	}

	public static IAgent createBDI() {
		Agent result = new Agent();
		BeliefBase bb = new BeliefBase();
		result.putService(IBeliefBase.class, bb);
		result.putService(IGoalBase.class, new GoalBase());
		return result;
	}

}
