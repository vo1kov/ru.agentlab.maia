package ru.agentlab.maia.agent;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.event.BeliefAddedEvent;
import ru.agentlab.maia.agent.event.BeliefRemovedEvent;
import ru.agentlab.maia.agent.event.GoalAddedEvent;
import ru.agentlab.maia.agent.event.GoalFailedEvent;
import ru.agentlab.maia.agent.event.GoalFinishedEvent;
import ru.agentlab.maia.agent.event.GoalRemovedEvent;
import ru.agentlab.maia.agent.event.RoleAddedEvent;
import ru.agentlab.maia.agent.event.RoleRemovedEvent;
import ru.agentlab.maia.agent.event.RoleResolvedEvent;
import ru.agentlab.maia.agent.event.RoleUnresolvedEvent;
import ru.agentlab.maia.agent.match.event.BeliefBaseEventMatcher;
import ru.agentlab.maia.agent.match.event.GoalBaseEventMatcher;
import ru.agentlab.maia.agent.match.event.RoleBaseEventMatcher;
import ru.agentlab.maia.agent.match.state.HaveBeliefMatcher;
import ru.agentlab.maia.agent.match.state.HaveGoalMatcher;
import ru.agentlab.maia.agent.match.state.HaveRoleMatcher;
import ru.agentlab.maia.annotation.BeliefAdded;
import ru.agentlab.maia.annotation.BeliefRemoved;
import ru.agentlab.maia.annotation.GoalAdded;
import ru.agentlab.maia.annotation.GoalFailed;
import ru.agentlab.maia.annotation.GoalFinished;
import ru.agentlab.maia.annotation.GoalRemoved;
import ru.agentlab.maia.annotation.HaveBelief;
import ru.agentlab.maia.annotation.HaveGoal;
import ru.agentlab.maia.annotation.HaveRole;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;

public class Converter {

	public static IPlan toPlan(Method method) {
		Plan plan = new Plan();
		for (Annotation annotation : method.getAnnotations()) {
			if (annotation instanceof BeliefAdded) {
				plan.setEventMatcher(toMatcher((BeliefAdded) annotation));
			} else if (annotation instanceof BeliefRemoved) {
				plan.setEventMatcher(toMatcher((BeliefRemoved) annotation));
			} else if (annotation instanceof GoalAdded) {
				plan.setEventMatcher(toMatcher((GoalAdded) annotation));
			} else if (annotation instanceof GoalRemoved) {
				plan.setEventMatcher(toMatcher((GoalRemoved) annotation));
			} else if (annotation instanceof GoalFailed) {
				plan.setEventMatcher(toMatcher((GoalFailed) annotation));
			} else if (annotation instanceof GoalFinished) {
				plan.setEventMatcher(toMatcher((GoalFinished) annotation));
			} else if (annotation instanceof RoleAdded) {
				plan.setEventMatcher(toMatcher((RoleAdded) annotation));
			} else if (annotation instanceof RoleRemoved) {
				plan.setEventMatcher(toMatcher((RoleRemoved) annotation));
			} else if (annotation instanceof RoleResolved) {
				plan.setEventMatcher(toMatcher((RoleResolved) annotation));
			} else if (annotation instanceof RoleUnresolved) {
				plan.setEventMatcher(toMatcher((RoleUnresolved) annotation));
			} else if (annotation instanceof HaveBelief) {
				plan.addStateMatcher(toMatcher((HaveBelief) annotation));
			} else if (annotation instanceof HaveGoal) {
				plan.addStateMatcher(toMatcher((HaveGoal) annotation));
			} else if (annotation instanceof HaveRole) {
				plan.addStateMatcher(toMatcher((HaveRole) annotation));
			}
		}
		return plan;
	}

	private static IStateMatcher toMatcher(HaveRole ann) {
		Class<?> value = ann.value();
		IStateMatcher matcher = new HaveRoleMatcher(value);
		return matcher;
	}

	private static IStateMatcher toMatcher(HaveGoal ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IStateMatcher matcher = new HaveGoalMatcher(triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	private static IStateMatcher toMatcher(HaveBelief ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IStateMatcher matcher = new HaveBeliefMatcher(triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(RoleUnresolved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleUnresolvedEvent.class, value);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(RoleResolved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleResolvedEvent.class, value);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(RoleRemoved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleRemovedEvent.class, value);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(RoleAdded ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleAddedEvent.class, value);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(GoalFinished ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalFinishedEvent.class, triplet[0], triplet[1],
				triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(GoalFailed ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalFailedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(GoalRemoved ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalRemovedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(GoalAdded ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalAddedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(BeliefRemoved ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new BeliefBaseEventMatcher(BeliefRemovedEvent.class, triplet[0], triplet[1],
				triplet[2]);
		return matcher;
	}

	private static IEventMatcher<?> toMatcher(BeliefAdded ann) {
		String value = ann.value();
		String[] triplet = getTriplet(value);
		IEventMatcher<?> matcher = new BeliefBaseEventMatcher(BeliefAddedEvent.class, triplet[0], triplet[1],
				triplet[2]);
		return matcher;
	}

	private static String[] getTriplet(String template) {
		String[] triplet = template.split(" ");
		if (triplet.length != 3) {
			throw new IllegalArgumentException("@ have wrong template");
		}
		return triplet;
	}

}
