package ru.agentlab.maia.agent.converter;

import static ru.agentlab.maia.EventType.BELIEF_CLASSIFICATION_ADDED;
import static ru.agentlab.maia.EventType.BELIEF_CLASSIFICATION_REMOVED;
import static ru.agentlab.maia.EventType.BELIEF_DATA_PROPERTY_ADDED;
import static ru.agentlab.maia.EventType.BELIEF_DATA_PROPERTY_REMOVED;
import static ru.agentlab.maia.EventType.BELIEF_OBJECT_PROPERTY_ADDED;
import static ru.agentlab.maia.EventType.BELIEF_OBJECT_PROPERTY_REMOVED;
import static ru.agentlab.maia.EventType.GOAL_CLASSIFICATION_ADDED;
import static ru.agentlab.maia.EventType.GOAL_CLASSIFICATION_FAILED;
import static ru.agentlab.maia.EventType.GOAL_CLASSIFICATION_FINISHED;
import static ru.agentlab.maia.EventType.GOAL_CLASSIFICATION_REMOVED;
import static ru.agentlab.maia.EventType.GOAL_DATA_PROPERTY_ADDED;
import static ru.agentlab.maia.EventType.GOAL_DATA_PROPERTY_FAILED;
import static ru.agentlab.maia.EventType.GOAL_DATA_PROPERTY_FINISHED;
import static ru.agentlab.maia.EventType.GOAL_DATA_PROPERTY_REMOVED;
import static ru.agentlab.maia.EventType.GOAL_OBJECT_PROPERTY_ADDED;
import static ru.agentlab.maia.EventType.GOAL_OBJECT_PROPERTY_FAILED;
import static ru.agentlab.maia.EventType.GOAL_OBJECT_PROPERTY_FINISHED;
import static ru.agentlab.maia.EventType.GOAL_OBJECT_PROPERTY_REMOVED;
import static ru.agentlab.maia.EventType.ROLE_ADDED;
import static ru.agentlab.maia.EventType.ROLE_REMOVED;
import static ru.agentlab.maia.EventType.ROLE_RESOLVED;
import static ru.agentlab.maia.EventType.ROLE_UNRESOLVED;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.JavaClassMatcher;
import ru.agentlab.maia.agent.match.OWLClassAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLDataPropertyAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLNamedObjectStaticMatcher;
import ru.agentlab.maia.agent.match.OWLNamedObjectVariableMatcher;
import ru.agentlab.maia.agent.match.OWLObjectPropertyAssertionAxiomMatcher;
import ru.agentlab.maia.annotation.BeliefClassificationAdded;
import ru.agentlab.maia.annotation.BeliefClassificationRemoved;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.BeliefDataPropertyRemoved;
import ru.agentlab.maia.annotation.BeliefObjectPropertyAdded;
import ru.agentlab.maia.annotation.BeliefObjectPropertyRemoved;
import ru.agentlab.maia.annotation.GoalClassificationAdded;
import ru.agentlab.maia.annotation.GoalClassificationFailed;
import ru.agentlab.maia.annotation.GoalClassificationFinished;
import ru.agentlab.maia.annotation.GoalClassificationRemoved;
import ru.agentlab.maia.annotation.GoalDataPropertyAdded;
import ru.agentlab.maia.annotation.GoalDataPropertyFailed;
import ru.agentlab.maia.annotation.GoalDataPropertyFinished;
import ru.agentlab.maia.annotation.GoalDataPropertyRemoved;
import ru.agentlab.maia.annotation.GoalObjectPropertyAdded;
import ru.agentlab.maia.annotation.GoalObjectPropertyFailed;
import ru.agentlab.maia.annotation.GoalObjectPropertyFinished;
import ru.agentlab.maia.annotation.GoalObjectPropertyRemoved;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;

public class Converter {

	public static IPlan addPlan(Method method, IPlanBase planBase) {
		Plan plan = new Plan();
		EventType type = null;
		try {
			for (Annotation annotation : method.getAnnotations()) {
				if (annotation instanceof BeliefDataPropertyAdded) {
					IMatcher<?> matcher = toMatcher((BeliefDataPropertyAdded) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_DATA_PROPERTY_ADDED;
				} else if (annotation instanceof BeliefDataPropertyRemoved) {
					IMatcher<?> matcher = toMatcher((BeliefDataPropertyRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_DATA_PROPERTY_REMOVED;
				} else if (annotation instanceof BeliefObjectPropertyAdded) {
					IMatcher<?> matcher = toMatcher((BeliefObjectPropertyAdded) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_OBJECT_PROPERTY_ADDED;
				} else if (annotation instanceof BeliefObjectPropertyRemoved) {
					IMatcher<?> matcher = toMatcher((BeliefObjectPropertyRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_OBJECT_PROPERTY_REMOVED;
				} else if (annotation instanceof BeliefClassificationAdded) {
					IMatcher<?> matcher = toMatcher((BeliefClassificationAdded) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_CLASSIFICATION_ADDED;
				} else if (annotation instanceof BeliefClassificationRemoved) {
					IMatcher<?> matcher = toMatcher((BeliefClassificationRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = BELIEF_CLASSIFICATION_REMOVED;
				} else if (annotation instanceof GoalClassificationAdded) {
					IMatcher<?> matcher = toMatcher((GoalClassificationAdded) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_ADDED;
				} else if (annotation instanceof GoalClassificationRemoved) {
					IMatcher<?> matcher = toMatcher((GoalClassificationRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_REMOVED;
				} else if (annotation instanceof GoalClassificationFailed) {
					IMatcher<?> matcher = toMatcher((GoalClassificationFailed) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_FAILED;
				} else if (annotation instanceof GoalClassificationFinished) {
					IMatcher<?> matcher = toMatcher((GoalClassificationFinished) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_FINISHED;
				} else if (annotation instanceof GoalDataPropertyAdded) {
					IMatcher<?> matcher = toMatcher((GoalDataPropertyAdded) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_ADDED;
				} else if (annotation instanceof GoalDataPropertyRemoved) {
					IMatcher<?> matcher = toMatcher((GoalDataPropertyRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_REMOVED;
				} else if (annotation instanceof GoalDataPropertyFailed) {
					IMatcher<?> matcher = toMatcher((GoalDataPropertyFailed) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_FAILED;
				} else if (annotation instanceof GoalDataPropertyFinished) {
					IMatcher<?> matcher = toMatcher((GoalDataPropertyFinished) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_FINISHED;
				} else if (annotation instanceof GoalObjectPropertyAdded) {
					IMatcher<?> matcher = toMatcher((GoalObjectPropertyAdded) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_ADDED;
				} else if (annotation instanceof GoalObjectPropertyRemoved) {
					IMatcher<?> matcher = toMatcher((GoalObjectPropertyRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_REMOVED;
				} else if (annotation instanceof GoalObjectPropertyFailed) {
					IMatcher<?> matcher = toMatcher((GoalObjectPropertyFailed) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_FAILED;
				} else if (annotation instanceof GoalObjectPropertyFinished) {
					IMatcher<?> matcher = toMatcher((GoalObjectPropertyFinished) annotation);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_FINISHED;
				} else if (annotation instanceof RoleAdded) {
					IMatcher<?> matcher = toMatcher((RoleAdded) annotation);
					plan.setEventMatcher(matcher);
					type = ROLE_ADDED;
				} else if (annotation instanceof RoleRemoved) {
					IMatcher<?> matcher = toMatcher((RoleRemoved) annotation);
					plan.setEventMatcher(matcher);
					type = ROLE_REMOVED;
				} else if (annotation instanceof RoleResolved) {
					IMatcher<?> matcher = toMatcher((RoleResolved) annotation);
					plan.setEventMatcher(matcher);
					type = ROLE_RESOLVED;
				} else if (annotation instanceof RoleUnresolved) {
					IMatcher<?> matcher = toMatcher((RoleUnresolved) annotation);
					plan.setEventMatcher(matcher);
					type = ROLE_UNRESOLVED;
					// } else if (annotation instanceof HaveBelief) {
					// plan.setStateMatcher(toMatcher((HaveBelief) annotation));
					// } else if (annotation instanceof HaveGoal) {
					// plan.setStateMatcher(toMatcher((HaveGoal) annotation));
					// } else if (annotation instanceof HaveRole) {
					// plan.setStateMatcher(toMatcher((HaveRole) annotation));
				}
			}
		} catch (AnnotationFormatException e) {
			e.printStackTrace();
		}
		planBase.add(type, plan);
		return plan;
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(BeliefClassificationAdded annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(BeliefClassificationRemoved annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(BeliefDataPropertyRemoved annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(BeliefDataPropertyAdded annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(BeliefObjectPropertyAdded annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(BeliefObjectPropertyRemoved annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(GoalClassificationAdded annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(GoalClassificationFailed annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(GoalClassificationFinished annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLClassAssertionAxiom> toMatcher(GoalClassificationRemoved annotation)
			throws AnnotationFormatException {
		return getClassificationMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(GoalObjectPropertyAdded annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(GoalObjectPropertyFailed annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(GoalObjectPropertyFinished annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> toMatcher(GoalObjectPropertyRemoved annotation)
			throws AnnotationFormatException {
		return getOWLObjectPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(GoalDataPropertyAdded annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(GoalDataPropertyFailed annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(GoalDataPropertyFinished annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> toMatcher(GoalDataPropertyRemoved annotation)
			throws AnnotationFormatException {
		return getOWLDataPropertyMatcher(annotation.value());
	}

	protected static IMatcher<Class<?>> toMatcher(RoleAdded ann) {
		return new JavaClassMatcher(ann.value());
	}

	protected static IMatcher<Class<?>> toMatcher(RoleRemoved ann) {
		return new JavaClassMatcher(ann.value());
	}

	protected static IMatcher<Class<?>> toMatcher(RoleResolved ann) {
		return new JavaClassMatcher(ann.value());
	}

	protected static IMatcher<Class<?>> toMatcher(RoleUnresolved ann) {
		return new JavaClassMatcher(ann.value());
	}

	// protected static IMatcher toMatcher(HaveRole ann) {
	// Class<?> value = ann.value();
	// JavaClassMatcher template = getClassTemplate(value);
	// IMatcher matcher = new HaveRoleMatcher(value);
	// return matcher;
	// }
	//
	// protected static IMatcher toMatcher(HaveGoal ann) {
	// OWLAxiomMatcher tripleTemplate = getOWLDataPropertyMatcher(ann.value());
	// IMatcher matcher = new HaveGoalMatcher(tripleTemplate);
	// return matcher;
	// }
	//
	// protected static IMatcher toMatcher(HaveBelief ann) {
	// String value = ann.value();
	// String[] triplet = getOWLDataPropertyMatcher(value);
	// IMatcher matcher = new HaveBeliefClassificationMatcher(triplet[0],
	// triplet[1], triplet[2]);
	// return matcher;
	// }

	private static IMatcher<OWLDataPropertyAssertionAxiom> getOWLDataPropertyMatcher(String template)
			throws AnnotationFormatException {
		String[] triplet = template.split(" ");
		if (triplet.length != 3) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLDataPropertyAssertionAxiomMatcher(toTempleate(triplet[0]), toTempleate(triplet[1]), toTempleate(triplet[2]));
	}

	private static IMatcher<OWLObjectPropertyAssertionAxiom> getOWLObjectPropertyMatcher(String template)
			throws AnnotationFormatException {
		String[] triplet = template.split(" ");
		if (triplet.length != 3) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLObjectPropertyAssertionAxiomMatcher(toTempleate(triplet[0]), toTempleate(triplet[1]), toTempleate(triplet[2]));
	}

	private static IMatcher<OWLClassAssertionAxiom> getClassificationMatcher(String template)
			throws AnnotationFormatException {
		String[] triplet = template.split(" ");
		if (triplet.length != 2) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLClassAssertionAxiomMatcher(toTempleate(triplet[0]), toTempleate(triplet[1]));
	}

	private static IMatcher<OWLNamedObject> toTempleate(String string) throws AnnotationFormatException {
		if (string.startsWith("?")) {
			return new OWLNamedObjectVariableMatcher(string.substring(1));
		} else if (string.startsWith("<") && string.endsWith(">")) {
			return new OWLNamedObjectStaticMatcher(string);
		} else {
			throw new AnnotationFormatException();
		}
	}

}
