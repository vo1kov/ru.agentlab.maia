package ru.agentlab.maia.annotation2.converter;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBody;
import ru.agentlab.maia.IPlanFilter;
import ru.agentlab.maia.agent.IStateMatcher;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.PlanBodyFactory;
import ru.agentlab.maia.agent.PlanFilterFactory;
import ru.agentlab.maia.annotation2.AddedBelief;
import ru.agentlab.maia.annotation2.AddedGoal;
import ru.agentlab.maia.annotation2.AddedMessage;
import ru.agentlab.maia.annotation2.AddedRole;
import ru.agentlab.maia.annotation2.FailedGoal;
import ru.agentlab.maia.annotation2.InitialBelief;
import ru.agentlab.maia.annotation2.InitialGoal;
import ru.agentlab.maia.annotation2.RemovedBelief;
import ru.agentlab.maia.annotation2.RemovedMessage;
import ru.agentlab.maia.annotation2.RemovedRole;
import ru.agentlab.maia.annotation2.ResolvedRole;
import ru.agentlab.maia.annotation2.UnhandledMessage;
import ru.agentlab.maia.annotation2.UnresolvedRole;
import ru.agentlab.maia.exception.ConverterException;

/**
 * <!-- @formatter:off -->
 * [+] AddedBelief.java
 * [ ] AddedExternalEvent.java
 * [+] AddedGoal.java
 * [+] AddedMessage.java
 * [+] AddedRole.java
 * [+] FailedGoal.java
 * [ ] HaveBelief.java
 * [ ] HaveBeliefs.java
 * [ ] HaveGoal.java
 * [ ] HaveGoals.java
 * [+] InitialBelief.java
 * [+] InitialBeliefs.java
 * [+] InitialGoal.java
 * [+] InitialGoals.java
 * [ ] Prefix.java
 * [+] RemovedBelief.java
 * [+] RemovedMessage.java
 * [+] RemovedRole.java
 * [+] ResolvedRole.java
 * [+] UnhandledMessage.java
 * [+] UnresolvedRole.java
 * <!-- @formatter:on -->
 * 
 * @author Dmitriy Shishkin <shishkindimon@gmail.com>
 */
public class Converter {

	AxiomAnnotation2AxiomInstance axiomInstances;

	AxiomAnnotation2AxiomMatcher axiomMatchers;

	MessageAnnotation2MessageMatcher messageMatchers;

	RoleAnnotation2RoleMatcher roleMatchers;

	public Set<OWLAxiom> getInitialBeliefs(Object role) throws ConverterException {
		Set<OWLAxiom> result = new HashSet<>();
		for (InitialBelief initialBelief : role.getClass().getAnnotationsByType(InitialBelief.class)) {
			result.add(axiomInstances.getAxiom(initialBelief));
		}
		return result;
	}

	public Set<OWLAxiom> getInitialGoals(Object role) throws ConverterException {
		Set<OWLAxiom> result = new HashSet<>();
		for (InitialGoal initialGoal : role.getClass().getAnnotationsByType(InitialGoal.class)) {
			result.add(axiomInstances.getAxiom(initialGoal));
		}
		return result;
	}

	public Map<IPlan, EventType> getInitialPlans(Object role) throws ConverterException {
		Map<IPlan, EventType> result = new HashMap<>();
		Method[] methods = role.getClass().getDeclaredMethods();
		for (Method method : methods) {
			Map<String, Object> variables = new HashMap<>();
			Registration registration = getEventMatcher(method, variables);
			if (registration != null) {
				IStateMatcher stateMatcher = getStateMatcher(method, variables);
				IPlanBody planBody = PlanBodyFactory.create(role, method);
				IPlanFilter planFilter = PlanFilterFactory.create(registration.getMatcher(), variables, stateMatcher);
				IPlan plan = new Plan(role, planFilter, planBody);
				result.put(plan, registration.getEventType());
			}
		}
		return result;
	}

	private IStateMatcher getStateMatcher(Method method, Map<String, Object> variables) throws ConverterException {
		return null;
	}

	private Registration getEventMatcher(Method method, Map<String, Object> variables) throws ConverterException {
		// AddedBelief
		AddedBelief addedBelief = method.getAnnotation(AddedBelief.class);
		if (addedBelief != null) {
			return new Registration(axiomMatchers.getMatcher(addedBelief, variables), EventType.ADDED_BELIEF);
		}
		// RemovedBelief
		RemovedBelief removedBelief = method.getAnnotation(RemovedBelief.class);
		if (removedBelief != null) {
			return new Registration(axiomMatchers.getMatcher(removedBelief, variables), EventType.REMOVED_BELIEF);
		}
		// AddedGoal
		AddedGoal addedGoal = method.getAnnotation(AddedGoal.class);
		if (addedGoal != null) {
			return new Registration(axiomMatchers.getMatcher(addedGoal, variables), EventType.ADDED_GOAL);
		}
		// FailedGoal
		FailedGoal failedGoal = method.getAnnotation(FailedGoal.class);
		if (failedGoal != null) {
			return new Registration(axiomMatchers.getMatcher(failedGoal, variables), EventType.FAILED_GOAL);
		}
		// AddedMessage
		AddedMessage addedMessage = method.getAnnotation(AddedMessage.class);
		if (addedMessage != null) {
			return new Registration(messageMatchers.getMatcher(addedMessage, variables), EventType.ADDED_MESSAGE);
		}
		// RemovedMessage
		RemovedMessage failedMessage = method.getAnnotation(RemovedMessage.class);
		if (failedMessage != null) {
			return new Registration(messageMatchers.getMatcher(failedMessage, variables), EventType.REMOVED_MESSAGE);
		}
		// UnhandledMessage
		UnhandledMessage unhandledMessage = method.getAnnotation(UnhandledMessage.class);
		if (unhandledMessage != null) {
			return new Registration(messageMatchers.getMatcher(unhandledMessage, variables),
					EventType.UNHANDLED_MESSAGE);
		}
		// AddedRole
		AddedRole addedRole = method.getAnnotation(AddedRole.class);
		if (addedRole != null) {
			return new Registration(roleMatchers.getMatcher(addedRole, variables), EventType.ADDED_ROLE);
		}
		// RemovedRole
		RemovedRole removedRole = method.getAnnotation(RemovedRole.class);
		if (removedRole != null) {
			return new Registration(roleMatchers.getMatcher(removedRole, variables), EventType.REMOVED_ROLE);
		}
		// ResolvedRole
		ResolvedRole resolvedRole = method.getAnnotation(ResolvedRole.class);
		if (resolvedRole != null) {
			return new Registration(roleMatchers.getMatcher(resolvedRole, variables), EventType.RESOLVED_ROLE);
		}
		// UnresolvedRole
		UnresolvedRole unresolvedRole = method.getAnnotation(UnresolvedRole.class);
		if (unresolvedRole != null) {
			return new Registration(roleMatchers.getMatcher(unresolvedRole, variables), EventType.UNRESOLVED_ROLE);
		}
		return null;
	}

	static private final class Registration {

		private Matcher<?> matcher;

		private EventType eventType;

		public Registration(Matcher<?> matcher, EventType eventType) {
			this.matcher = matcher;
			this.eventType = eventType;
		}

		public Matcher<?> getMatcher() {
			return matcher;
		}

		public EventType getEventType() {
			return eventType;
		}

	}

}
