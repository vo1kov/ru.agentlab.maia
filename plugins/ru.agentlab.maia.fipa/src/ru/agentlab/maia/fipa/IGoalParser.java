package ru.agentlab.maia.fipa;

import ru.agentlab.maia.agent.IGoal;

@FunctionalInterface
public interface IGoalParser {

	IGoal parse(String content);

}
