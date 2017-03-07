package ru.agentlab.maia.service.message.fipa;

import ru.agentlab.maia.IGoal;

public interface IGoalEstimator {

	double estimate(IGoal goal);

}
