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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.semanticweb.owlapi.apibinding.OWLManager;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.model.OWLRuntimeException;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.JavaClassMatcher;
import ru.agentlab.maia.agent.match.OWLClassAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLDataPropertyAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;
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

	private static OWLOntologyManager manager = OWLManager.createOWLOntologyManager();

	private static OWLDataFactory factory = manager.getOWLDataFactory();

	// private static final Map<Class<?>, EventType> CLASSIFICATION_ANNOTATIONS
	// = new HashMap<>(6);
	// private static final Map<Class<?>, EventType> DATA_PROPERTY_ANNOTATIONS =
	// new HashMap<>(6);
	// private static final Map<Class<?>, EventType> OBJECT_PROPERTY_ANNOTATIONS
	// = new HashMap<>(6);
	// private static final Map<Class<?>, EventType> METHOD_ANNOTATIONS = new
	// HashMap<>(4);
	// private static final Map<Class<?>, EventType> CLASS_ANNOTATIONS = new
	// HashMap<>(4);
	//
	// static {
	// CLASSIFICATION_ANNOTATIONS.put(BeliefClassificationAdded.class,
	// EventType.BELIEF_CLASSIFICATION_ADDED);
	// CLASSIFICATION_ANNOTATIONS.put(BeliefClassificationRemoved.class,
	// EventType.BELIEF_CLASSIFICATION_REMOVED);
	// CLASSIFICATION_ANNOTATIONS.put(GoalClassificationAdded.class,
	// EventType.GOAL_CLASSIFICATION_ADDED);
	// CLASSIFICATION_ANNOTATIONS.put(GoalClassificationFailed.class,
	// EventType.GOAL_CLASSIFICATION_FAILED);
	// CLASSIFICATION_ANNOTATIONS.put(GoalClassificationFinished.class,
	// EventType.GOAL_CLASSIFICATION_FINISHED);
	// CLASSIFICATION_ANNOTATIONS.put(GoalClassificationRemoved.class,
	// EventType.GOAL_CLASSIFICATION_REMOVED);
	//
	// DATA_PROPERTY_ANNOTATIONS.put(BeliefDataPropertyAdded.class,
	// EventType.BELIEF_DATA_PROPERTY_ADDED);
	// DATA_PROPERTY_ANNOTATIONS.put(BeliefDataPropertyRemoved.class,
	// EventType.BELIEF_DATA_PROPERTY_REMOVED);
	// DATA_PROPERTY_ANNOTATIONS.put(GoalDataPropertyAdded.class,
	// EventType.GOAL_DATA_PROPERTY_ADDED);
	// DATA_PROPERTY_ANNOTATIONS.put(GoalDataPropertyFailed.class,
	// EventType.GOAL_DATA_PROPERTY_FAILED);
	// DATA_PROPERTY_ANNOTATIONS.put(GoalDataPropertyFinished.class,
	// EventType.GOAL_DATA_PROPERTY_FINISHED);
	// DATA_PROPERTY_ANNOTATIONS.put(GoalDataPropertyRemoved.class,
	// EventType.GOAL_DATA_PROPERTY_REMOVED);
	//
	// OBJECT_PROPERTY_ANNOTATIONS.put(BeliefObjectPropertyAdded.class,
	// EventType.BELIEF_OBJECT_PROPERTY_ADDED);
	// OBJECT_PROPERTY_ANNOTATIONS.put(BeliefObjectPropertyRemoved.class,
	// EventType.BELIEF_OBJECT_PROPERTY_REMOVED);
	// OBJECT_PROPERTY_ANNOTATIONS.put(GoalObjectPropertyAdded.class,
	// EventType.GOAL_OBJECT_PROPERTY_ADDED);
	// OBJECT_PROPERTY_ANNOTATIONS.put(GoalObjectPropertyFailed.class,
	// EventType.GOAL_OBJECT_PROPERTY_FAILED);
	// OBJECT_PROPERTY_ANNOTATIONS.put(GoalObjectPropertyFinished.class,
	// EventType.GOAL_OBJECT_PROPERTY_FINISHED);
	// OBJECT_PROPERTY_ANNOTATIONS.put(GoalObjectPropertyRemoved.class,
	// EventType.GOAL_OBJECT_PROPERTY_REMOVED);
	//
	// METHOD_ANNOTATIONS.put(PlanAdded.class, EventType.PLAN_ADDED);
	// METHOD_ANNOTATIONS.put(PlanFailed.class, EventType.PLAN_FAILED);
	// METHOD_ANNOTATIONS.put(PlanFinished.class, EventType.PLAN_FINISHED);
	// METHOD_ANNOTATIONS.put(PlanRemoved.class, EventType.PLAN_REMOVED);
	//
	// CLASS_ANNOTATIONS.put(RoleAdded.class, EventType.ROLE_ADDED);
	// CLASS_ANNOTATIONS.put(RoleRemoved.class, EventType.ROLE_REMOVED);
	// CLASS_ANNOTATIONS.put(RoleResolved.class, EventType.ROLE_RESOLVED);
	// CLASS_ANNOTATIONS.put(RoleUnresolved.class, EventType.ROLE_UNRESOLVED);
	// }

	protected static final String IRI_PREFIXED_REGEXP = "((\\w*:)?(\\S+))";

	protected static final String IRI_FULL_REGEXP = "(<(\\S+#)(\\S+)>)";

	protected static final String IRI_VARIABLE_REGEXP = "(\\?(\\S+))";

	/**
	 * Determines whether input string is either a literal with prefix, literal
	 * with full name or variable literal. Available groups:
	 * <ul>
	 * <li><b>Group #2</b> - literal with prefix;
	 * <ul>
	 * <li><b>Group #3</b> - optional prefix name, ends with '<code>:</code>';
	 * <li><b>Group #4</b> - local name of literal;
	 * </ul>
	 * <li><b>Group #5</b> - literal with full name, surrounded by angled
	 * brackets;
	 * <ul>
	 * <li><b>Group #6</b> - namespace, ends with '<code>#</code>';
	 * <li><b>Group #7</b> - local name of literal;
	 * </ul>
	 * <li><b>Group #8</b> - variable literal starting with '<code>?</code>';
	 * <ul>
	 * <li><b>Group #9</b> - variable name without '<code>?</code>' sign;
	 * </ul>
	 * </ul>
	 * 
	 * <p>
	 * <img src="./doc-files/LiteralRegExp.png" style=
	 * "max-width: 100%;" alt="LiteralRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 */
	protected static final Pattern IRI_PATTERN = Pattern
			.compile("(?s)^(" + IRI_PREFIXED_REGEXP + "|" + IRI_FULL_REGEXP + "|" + IRI_VARIABLE_REGEXP + ")$");

	/**
	 * Determines whether input string is datatype literal:
	 * <ul>
	 * <li><b>Group #1</b> - literal value with escaped '<code>@</code>'
	 * symbols;
	 * <li><b>Group #2</b> - literal language tag, starts with '<code>@</code>';
	 * <ul>
	 * <li><b>Group #3</b> - language tag value without '<code>@</code>';
	 * </ul>
	 * <li><b>Group #4</b> - literal datatype IRI, starts with '<code>^^</code>
	 * '; brackets;
	 * <ul>
	 * <li><b>Group #5</b> - literal datatype IRI without '<code>@</code>'; Has
	 * {@link #LITERAL_STATIC_PATTERN} format;
	 * </ul>
	 * </ul>
	 * 
	 * <p>
	 * <img src="./doc-files/DataTypeLiteralOrVarRegExp.png" style=
	 * "max-width: 100%;" alt="DataTypeLiteralOrVarRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 * 
	 * @see {@link #LITERAL_STATIC_PATTERN}
	 */
	protected static final Pattern LITERAL_DATATYPE_PATTERN = Pattern
			.compile("(?s)^(([^?].*?)|(\\?(\\w+)))(@([a-zA-Z-]*|(\\?(\\w+))))?(\\^\\^([^@]*))?$");

	/**
	 * <p>
	 * <img src="./doc-files/ClassAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="ClassAssertionRegExp" >
	 */
	protected static final Pattern CLASS_ASSERTION_PATTERN = Pattern.compile("^(\\S+)\\s+(\\S+)$");

	/**
	 * <p>
	 * <img src="./doc-files/DataPropertyAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="DataPropertyAssertionRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 */
	protected static final Pattern DATA_PROPERTY_ASSERTION_PATTERN = Pattern.compile("(?s)^(\\S+)\\s+(\\S+)\\s+(.*?)$");

	/**
	 * <p>
	 * <img src="./doc-files/ObjectPropertyAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="ObjectPropertyAssertionRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 */
	protected static final Pattern OBJECT_PROPERTY_ASSERTION_PATTERN = Pattern
			.compile("(?s)^(\\S+)\\s+(\\S+)\\s+(\\S+)$");

	protected static PrefixManager prefixManager = new DefaultPrefixManager();

	public static IPlan addPlan(Method method, IPlanBase planBase) {
		Plan plan = new Plan();
		EventType type = null;
		try {
			for (Annotation annotation : method.getAnnotations()) {
				if (annotation instanceof BeliefClassificationAdded) {
					String value = ((BeliefClassificationAdded) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_CLASSIFICATION_ADDED;
				} else if (annotation instanceof BeliefClassificationRemoved) {
					String value = ((BeliefClassificationRemoved) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_CLASSIFICATION_REMOVED;
				} else if (annotation instanceof BeliefDataPropertyAdded) {
					String value = ((BeliefDataPropertyAdded) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_DATA_PROPERTY_ADDED;
				} else if (annotation instanceof BeliefDataPropertyRemoved) {
					String value = ((BeliefDataPropertyRemoved) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_DATA_PROPERTY_REMOVED;
				} else if (annotation instanceof BeliefObjectPropertyAdded) {
					String value = ((BeliefObjectPropertyAdded) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_OBJECT_PROPERTY_ADDED;
				} else if (annotation instanceof BeliefObjectPropertyRemoved) {
					String value = ((BeliefObjectPropertyRemoved) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = BELIEF_OBJECT_PROPERTY_REMOVED;
				} else if (annotation instanceof GoalClassificationAdded) {
					String value = ((GoalClassificationAdded) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_ADDED;
				} else if (annotation instanceof GoalClassificationRemoved) {
					String value = ((GoalClassificationRemoved) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_REMOVED;
				} else if (annotation instanceof GoalClassificationFailed) {
					String value = ((GoalClassificationFailed) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_FAILED;
				} else if (annotation instanceof GoalClassificationFinished) {
					String value = ((GoalClassificationFinished) annotation).value();
					IMatcher<?> matcher = getOWLClassAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_CLASSIFICATION_FINISHED;
				} else if (annotation instanceof GoalDataPropertyAdded) {
					String value = ((GoalDataPropertyAdded) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_ADDED;
				} else if (annotation instanceof GoalDataPropertyRemoved) {
					String value = ((GoalDataPropertyRemoved) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_REMOVED;
				} else if (annotation instanceof GoalDataPropertyFailed) {
					String value = ((GoalDataPropertyFailed) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_FAILED;
				} else if (annotation instanceof GoalDataPropertyFinished) {
					String value = ((GoalDataPropertyFinished) annotation).value();
					IMatcher<?> matcher = getOWLDataPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_DATA_PROPERTY_FINISHED;
				} else if (annotation instanceof GoalObjectPropertyAdded) {
					String value = ((GoalObjectPropertyAdded) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_ADDED;
				} else if (annotation instanceof GoalObjectPropertyRemoved) {
					String value = ((GoalObjectPropertyRemoved) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_REMOVED;
				} else if (annotation instanceof GoalObjectPropertyFailed) {
					String value = ((GoalObjectPropertyFailed) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_FAILED;
				} else if (annotation instanceof GoalObjectPropertyFinished) {
					String value = ((GoalObjectPropertyFinished) annotation).value();
					IMatcher<?> matcher = getOWLObjectPropertyAssertionAxiomMatcher(value);
					plan.setEventMatcher(matcher);
					type = GOAL_OBJECT_PROPERTY_FINISHED;
				} else if (annotation instanceof RoleAdded) {
					Class<?> value = ((RoleAdded) annotation).value();
					IMatcher<?> matcher = new JavaClassMatcher(value);
					plan.setEventMatcher(matcher);
					type = ROLE_ADDED;
				} else if (annotation instanceof RoleRemoved) {
					Class<?> value = ((RoleRemoved) annotation).value();
					IMatcher<?> matcher = new JavaClassMatcher(value);
					plan.setEventMatcher(matcher);
					type = ROLE_REMOVED;
				} else if (annotation instanceof RoleResolved) {
					Class<?> value = ((RoleResolved) annotation).value();
					IMatcher<?> matcher = new JavaClassMatcher(value);
					plan.setEventMatcher(matcher);
					type = ROLE_RESOLVED;
				} else if (annotation instanceof RoleUnresolved) {
					Class<?> value = ((RoleUnresolved) annotation).value();
					IMatcher<?> matcher = new JavaClassMatcher(value);
					plan.setEventMatcher(matcher);
					type = ROLE_UNRESOLVED;
				}
			}
		} catch (AnnotationFormatException e) {
			e.printStackTrace();
		}
		planBase.add(type, plan);
		return plan;
	}

	// private static <T> T getMethodValue(Object object, String methodName,
	// Class<T> clazz) throws NoSuchMethodException,
	// SecurityException, IllegalAccessException, IllegalArgumentException,
	// InvocationTargetException {
	// Method valueMethod = object.getClass().getMethod(methodName);
	// Object result = valueMethod.invoke(object);
	// return clazz.cast(result);
	// }

	protected static IMatcher<OWLClassAssertionAxiom> getOWLClassAssertionAxiomMatcher(String template)
			throws AnnotationFormatException {
		Matcher match = CLASS_ASSERTION_PATTERN.matcher(template);
		if (!match.matches()) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLClassAssertionAxiomMatcher(getOWLNamedObjectMatcher(match.group(1)), getOWLNamedObjectMatcher(match.group(2)));
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> getOWLDataPropertyAssertionAxiomMatcher(String template)
			throws AnnotationFormatException {
		Matcher match = DATA_PROPERTY_ASSERTION_PATTERN.matcher(template);
		if (!match.matches()) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLDataPropertyAssertionAxiomMatcher(getOWLNamedObjectMatcher(match.group(1)),
				getOWLNamedObjectMatcher(match.group(2)), getOWLLiteralMatcher(match.group(3)));
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> getOWLObjectPropertyAssertionAxiomMatcher(
			String template) throws AnnotationFormatException {
		Matcher match = OBJECT_PROPERTY_ASSERTION_PATTERN.matcher(template);
		if (!match.matches()) {
			throw new AnnotationFormatException("@ have wrong template");
		}
		return new OWLObjectPropertyAssertionAxiomMatcher(getOWLNamedObjectMatcher(match.group(1)),
				getOWLNamedObjectMatcher(match.group(1)), getOWLNamedObjectMatcher(match.group(2)));
	}

	protected static IMatcher<OWLNamedObject> getOWLNamedObjectMatcher(String string) throws AnnotationFormatException {
		if (string.startsWith("?")) {
			return new OWLNamedObjectVariableMatcher(string.substring(1));
		} else if (string.startsWith("<") && string.endsWith(">")) {
			OWLNamedIndividual individual = factory.getOWLNamedIndividual(IRI.create(string));
			return new OWLNamedObjectStaticMatcher(individual);
		} else {
			throw new AnnotationFormatException();
		}
	}

	protected static IMatcher<OWLLiteral> getOWLLiteralMatcher(String string) throws AnnotationFormatException {
		String[] split = splitDatatypeLiteral(string);
		String literal = split[0];
		String language = split[1];
		String datatype = split[2];
		IRI datatypeIRI = null;
		Matcher matcher = matchLiteral(datatype);
		if (!matcher.matches()) {
			throw new AnnotationFormatException(
					"Literal [" + string + "] has wrong format. Datatype [" + datatype + "] does not match pattern.");
		}
		if (!isVariable(matcher)) {
			datatypeIRI = getIRI(matcher);
		}
		OWL2Datatype owl2datatype;
		try {
			owl2datatype = OWL2Datatype.getDatatype(datatypeIRI);
		} catch (OWLRuntimeException e) {
			throw new AnnotationFormatException("Literal [" + string + "] has wrong format. Datatype [" + datatypeIRI
					+ "] is not build-in datatype");
		}
		if (!owl2datatype.isInLexicalSpace(literal)) {
			throw new AnnotationFormatException("Literal [" + string + "] has wrong format. [" + literal
					+ "] is not in lexical space of datatype [" + datatypeIRI + "]");
		}
		OWLLiteral owlliteral = factory.getOWLLiteral(literal, owl2datatype);
		return new OWLLiteralMatcher(owlliteral);
	}

	protected static String[] splitDatatypeLiteral(String string) {
		String[] result = new String[3];
		String value = string;
		String language = null;
		String datatype = null;
		int datatypeIndex = string.lastIndexOf("^^");
		if (datatypeIndex != -1) {
			value = string.substring(0, datatypeIndex);
			datatype = string.substring(datatypeIndex + 2, string.length());
		}
		int languageIndex = value.lastIndexOf("@");
		if (languageIndex != -1) {
			language = value.substring(languageIndex + 1, value.length());
			value = value.substring(0, languageIndex);
		}
		result[0] = value;
		result[1] = language;
		result[2] = datatype;
		return result;
	}

	private static IRI getIRI(Matcher match) throws AnnotationFormatException {
		if (match.group(5) != null) {
			return IRI.create(match.group(6), match.group(7));
		} else if (match.group(2) != null) {
			String prefix = prefixManager.getPrefix(match.group(3));
			if (prefix == null) {
				throw new AnnotationFormatException(""); // TODO: add message
			}
			return IRI.create(prefix, match.group(4));
		} else {
			return null;
		}
	}

	private static Matcher matchLiteral(String string) {
		return LITERAL_PATTERN.matcher(string);
	}

	private static boolean isFullIRI(Matcher match) {
		return match.group(5) != null;
	}

	private static IRI getFullIRI(Matcher match) {
		return IRI.create(match.group(6), match.group(7));
	}

	private static boolean isPrefixedIRI(Matcher match) {
		return match.group(2) != null;
	}

	private static IRI getPrefixedIRI(Matcher match) {
		return IRI.create(match.group(3), match.group(4));
	}

	private static boolean isVariable(Matcher match) {
		return match.group(8) != null;
	}

	private static String getVariable(Matcher match) {
		return match.group(8);
	}

}
