package ru.agentlab.maia.agent.converter;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.match.IEventMatcher;
import ru.agentlab.maia.agent.match.IStateMatcher;
import ru.agentlab.maia.agent.match.common.JavaClassMatcher;
import ru.agentlab.maia.agent.match.common.OWLNamedObjectStaticMatcher;
import ru.agentlab.maia.agent.match.common.OWLNamedObjectVariableMatcher;
import ru.agentlab.maia.agent.match.event.BeliefBaseEventMatcher;
import ru.agentlab.maia.agent.match.event.GoalBaseEventMatcher;
import ru.agentlab.maia.agent.match.event.RoleBaseEventMatcher;
import ru.agentlab.maia.agent.match.state.HaveBeliefClassificationMatcher;
import ru.agentlab.maia.agent.match.state.HaveGoalMatcher;
import ru.agentlab.maia.agent.match.state.HaveRoleMatcher;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.BeliefDataPropertyRemoved;
import ru.agentlab.maia.annotation.GoalClassificationAdded;
import ru.agentlab.maia.annotation.GoalClassificationFailed;
import ru.agentlab.maia.annotation.GoalClassificationFinished;
import ru.agentlab.maia.annotation.GoalClassificationRemoved;
import ru.agentlab.maia.annotation.HaveBelief;
import ru.agentlab.maia.annotation.HaveGoal;
import ru.agentlab.maia.annotation.HaveRole;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;
import ru.agentlab.maia.event.BeliefClassificationAddedEvent;
import ru.agentlab.maia.event.BeliefClassificationRemovedEvent;
import ru.agentlab.maia.event.GoalClassificationAddedEvent;
import ru.agentlab.maia.event.GoalClassificationFailedEvent;
import ru.agentlab.maia.event.GoalClassificationFinishedEvent;
import ru.agentlab.maia.event.GoalClassificationRemovedEvent;
import ru.agentlab.maia.event.RoleAddedEvent;
import ru.agentlab.maia.event.RoleRemovedEvent;
import ru.agentlab.maia.event.RoleResolvedEvent;
import ru.agentlab.maia.event.RoleUnresolvedEvent;

public class Converter {

	public static IPlan toPlan(Method method) {
		Plan plan = new Plan();
		for (Annotation annotation : method.getAnnotations()) {
			if (annotation instanceof BeliefDataPropertyAdded) {
				plan.setEventMatcher(toMatcher((BeliefDataPropertyAdded) annotation));
			} else if (annotation instanceof BeliefDataPropertyRemoved) {
				plan.setEventMatcher(toMatcher((BeliefDataPropertyRemoved) annotation));
			} else if (annotation instanceof GoalClassificationAdded) {
				plan.setEventMatcher(toMatcher((GoalClassificationAdded) annotation));
			} else if (annotation instanceof GoalClassificationRemoved) {
				plan.setEventMatcher(toMatcher((GoalClassificationRemoved) annotation));
			} else if (annotation instanceof GoalClassificationFailed) {
				plan.setEventMatcher(toMatcher((GoalClassificationFailed) annotation));
			} else if (annotation instanceof GoalClassificationFinished) {
				plan.setEventMatcher(toMatcher((GoalClassificationFinished) annotation));
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

	protected static IStateMatcher toMatcher(HaveRole ann) {
		Class<?> value = ann.value();
		JavaClassMatcher template = getClassTemplate(value);
		IStateMatcher matcher = new HaveRoleMatcher(value);
		return matcher;
	}

	protected static IStateMatcher toMatcher(HaveGoal ann) {
		OWLAxiomMatcher tripleTemplate = getTripleTemplate(ann.value());
		IStateMatcher matcher = new HaveGoalMatcher(tripleTemplate);
		return matcher;
	}

	protected static IStateMatcher toMatcher(HaveBelief ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IStateMatcher matcher = new HaveBeliefClassificationMatcher(triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(RoleUnresolved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleUnresolvedEvent.class, value);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(RoleResolved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleResolvedEvent.class, value);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(RoleRemoved ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleRemovedEvent.class, value);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(RoleAdded ann) {
		Class<?> value = ann.value();
		IEventMatcher<?> matcher = new RoleBaseEventMatcher(RoleAddedEvent.class, value);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(GoalClassificationFinished ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalClassificationFinishedEvent.class, triplet[0], triplet[1],
				triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(GoalClassificationFailed ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalClassificationFailedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(GoalClassificationRemoved ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalClassificationRemovedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(GoalClassificationAdded ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new GoalBaseEventMatcher(GoalClassificationAddedEvent.class, triplet[0], triplet[1], triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(BeliefDataPropertyRemoved ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new BeliefBaseEventMatcher(BeliefClassificationRemovedEvent.class, triplet[0],
				triplet[1], triplet[2]);
		return matcher;
	}

	protected static IEventMatcher<?> toMatcher(BeliefDataPropertyAdded ann) {
		String value = ann.value();
		String[] triplet = getTripleTemplate(value);
		IEventMatcher<?> matcher = new BeliefBaseEventMatcher(BeliefClassificationAddedEvent.class, triplet[0],
				triplet[1], triplet[2]);
		return matcher;
	}

	private static OWLAxiomMatcher getTripleTemplate(String template)
			throws LiteralFormatException, TemplateFormatException {
		String[] triplet = template.split(" ");
		if (triplet.length != 3) {
			throw new TemplateFormatException("@ have wrong template");
		}
		return new OWLAxiomMatcher(toTempleate(triplet[0]), toTempleate(triplet[1]), toTempleate(triplet[2]));
	}

	private static OWLNamedObjectMatcher toTempleate(String string) throws LiteralFormatException {
		if (string.startsWith("?")) {
			return new OWLNamedObjectVariableMatcher(string.substring(1));
		} else if (string.startsWith("<") && string.endsWith(">")) {
			return new OWLNamedObjectStaticMatcher(string);
		} else {
			throw new LiteralFormatException();
		}
	}

	private static JavaClassMatcher getClassTemplate(Class<?> clazz) {
		return new JavaClassMatcher(clazz);
	}

}
