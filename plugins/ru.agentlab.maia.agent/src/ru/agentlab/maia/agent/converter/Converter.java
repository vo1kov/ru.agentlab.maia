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
import java.util.HashSet;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDatatype;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.IPlanBase;
import ru.agentlab.maia.agent.Plan;
import ru.agentlab.maia.agent.match.IMatcher;
import ru.agentlab.maia.agent.match.JavaAnyMatcher;
import ru.agentlab.maia.agent.match.JavaClassMatcher;
import ru.agentlab.maia.agent.match.JavaStringMatcher;
import ru.agentlab.maia.agent.match.OWLClassAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLDataPropertyAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.OWLLiteralMatcher;
import ru.agentlab.maia.agent.match.OWLNamedObjectMatcher;
import ru.agentlab.maia.agent.match.OWLObjectPropertyAssertionAxiomMatcher;
import ru.agentlab.maia.agent.match.VariableMatcher;
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
import ru.agentlab.maia.annotation.Prefix;
import ru.agentlab.maia.annotation.RoleAdded;
import ru.agentlab.maia.annotation.RoleRemoved;
import ru.agentlab.maia.annotation.RoleResolved;
import ru.agentlab.maia.annotation.RoleUnresolved;

public class Converter {

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

	private static final String SEPARATOR_LANGUAGE = "@";

	private static final String SEPARATOR_DATATYPE = "^^";

	protected static final String REGEXP_LITERAL_PREFIXED = "((\\w*:)?(\\S+))";

	protected static final String REGEXP_LITERAL_FULL = "(<(\\S+#)(\\S+)>)";

	protected static final String REGEXP_VARIABLE = "(\\?(\\S+))";

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
	protected static final Pattern PATTERN_LITERAL = Pattern
			.compile("(?s)^(" + REGEXP_VARIABLE + "|" + REGEXP_LITERAL_FULL + "|" + REGEXP_LITERAL_PREFIXED + ")$");
	protected static final int PATTERN_LITERAL_VARIABLE_GROUP = 2;
	protected static final int PATTERN_LITERAL_VARIABLE_VALUE = 3;
	protected static final int PATTERN_LITERAL_FULLIRI_GROUP = 4;
	protected static final int PATTERN_LITERAL_FULLIRI_NAMESPACE = 5;
	protected static final int PATTERN_LITERAL_FULLIRI_NAME = 6;
	protected static final int PATTERN_LITERAL_PREFIXEDIRI_GROUP = 7;
	protected static final int PATTERN_LITERAL_PREFIXEDIRI_PREFIX = 8;
	protected static final int PATTERN_LITERAL_PREFIXEDIRI_NAME = 9;

	protected static final Pattern PATTERN_VARIABLE = Pattern.compile("(?s)^" + REGEXP_VARIABLE + "$");
	protected static final int PATTERN_VARIABLE_NAME = 2;

	/**
	 * <p>
	 * <img src="./doc-files/ClassAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="ClassAssertionRegExp" >
	 */
	protected static final Pattern PATTERN_CLASS_ASSERTION = Pattern.compile("^\\s*?(\\S+)\\s+(\\S+)\\s*?$");
	protected static final int PATTERN_CLASS_ASSERTION_CLASS = 1;
	protected static final int PATTERN_CLASS_ASSERTION_INDIVIDUAL = 2;

	/**
	 * <p>
	 * <img src="./doc-files/DataPropertyAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="DataPropertyAssertionRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 */
	protected static final Pattern PATTERN_DATA_PROPERTY_ASSERTION = Pattern.compile("(?s)^(\\S+)\\s+(\\S+)\\s+(.*?)$");
	protected static final int PATTERN_DATA_PROPERTY_ASSERTION_SUBJECT = 1;
	protected static final int PATTERN_DATA_PROPERTY_ASSERTION_PROPERTY = 2;
	protected static final int PATTERN_DATA_PROPERTY_ASSERTION_OBJECT = 3;

	/**
	 * <p>
	 * <img src="./doc-files/ObjectPropertyAssertionRegExp.png" style=
	 * "max-width: 100%;" alt="ObjectPropertyAssertionRegExp" >
	 * <p align="right">
	 * <small>Visualized with
	 * <a href="https://jex.im/regulex/">https://jex.im/regulex/</a></small>
	 */
	protected static final Pattern PATTERN_OBJECT_PROPERTY_ASSERTION = Pattern
			.compile("(?s)^\\s*?(\\S+)\\s+(\\S+)\\s+(\\S+)\\s*?$");
	protected static final int PATTERN_OBJECT_PROPERTY_ASSERTION_SUBJECT = 1;
	protected static final int PATTERN_OBJECT_PROPERTY_ASSERTION_PROPERTY = 2;
	protected static final int PATTERN_OBJECT_PROPERTY_ASSERTION_OBJECT = 3;

	static Set<String> BUILDIN_DATATYPE_NAMESPACES = new HashSet<>();
	static {
		BUILDIN_DATATYPE_NAMESPACES.add(Namespaces.OWL.toString());
		BUILDIN_DATATYPE_NAMESPACES.add(Namespaces.RDF.toString());
		BUILDIN_DATATYPE_NAMESPACES.add(Namespaces.RDFS.toString());
		BUILDIN_DATATYPE_NAMESPACES.add(Namespaces.XSD.toString());
	}

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

	protected static IMatcher<OWLClassAssertionAxiom> getOWLClassAssertionAxiomMatcher(String template)
			throws AnnotationFormatException {
		String[] parts = splitClassAssertioin(template);
		String individual = parts[0];
		String clazz = parts[1];
		return new OWLClassAssertionAxiomMatcher(getOWLClassMatcher(clazz), getOWLNamedIndividualMatcher(individual));
	}

	protected static IMatcher<OWLDataPropertyAssertionAxiom> getOWLDataPropertyAssertionAxiomMatcher(String template)
			throws AnnotationFormatException {
		String[] parts = splitDataPropertyAssertioin(template);
		String subject = parts[0];
		String property = parts[1];
		String object = parts[2];
		return new OWLDataPropertyAssertionAxiomMatcher(getOWLNamedIndividualMatcher(subject),
				getOWLDataPropertyMatcher(property), getOWLLiteralMatcher(object));
	}

	protected static IMatcher<OWLObjectPropertyAssertionAxiom> getOWLObjectPropertyAssertionAxiomMatcher(
			String template) throws AnnotationFormatException {
		String[] parts = splitObjectPropertyAssertioin(template);
		String subject = parts[0];
		String property = parts[1];
		String data = parts[2];
		return new OWLObjectPropertyAssertionAxiomMatcher(getOWLNamedIndividualMatcher(subject),
				getOWLObjectPropertyMatcher(property), getOWLNamedIndividualMatcher(data));
	}

	protected static IMatcher<? super OWLLiteral> getOWLLiteralMatcher(String string) throws LiteralFormatException {
		String[] parts = splitDatatypeLiteral(string);
		String literal = parts[0];
		String language = parts[1];
		String datatype = parts[2];
		IMatcher<? super OWLDatatype> datatypeMatcher = getOWLDatatypeMatcher(datatype);
		IMatcher<? super String> literalMatcher = getStringMatcher(literal);
		IMatcher<? super String> languageMatcher = getStringMatcher(language);
		if ((datatypeMatcher instanceof OWLNamedObjectMatcher)) {
			IRI datatypeIRI = ((OWLNamedObjectMatcher) datatypeMatcher).getValue();
			String datatypeNamespace = datatypeIRI.getNamespace();
			if (BUILDIN_DATATYPE_NAMESPACES.contains(datatypeNamespace)) {
				if (OWL2Datatype.isBuiltIn(datatypeIRI)) {
					OWL2Datatype owl2datatype = OWL2Datatype.getDatatype(datatypeIRI);
					if (!(literalMatcher instanceof VariableMatcher) && !owl2datatype.isInLexicalSpace(literal)) {
						throw new LiteralNotInLexicalSpaceException("Literal [" + string + "] has wrong format. Value ["
								+ literal + "] is not in lexical space of datatype [" + datatypeIRI.toQuotedString()
								+ "]");
					}
				} else {
					throw new LiteralWrongBuildInDatatypeException(
							"Literal [" + string + "] has wrong format. Ontology [" + datatypeNamespace
									+ "] does not contain build-in datatype [" + datatypeIRI.toQuotedString() + "]");
				}
			}
		}
		return new OWLLiteralMatcher(literalMatcher, languageMatcher, datatypeMatcher);
	}

	protected static IMatcher<? super OWLDatatype> getOWLDatatypeMatcher(String string) throws LiteralFormatException {
		if (string == null) {
			return new OWLNamedObjectMatcher(OWL2Datatype.RDF_PLAIN_LITERAL.getIRI());
		}
		return getOWLNamedObjectMatcher(string);
	}

	protected static IMatcher<? super OWLNamedIndividual> getOWLNamedIndividualMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected static IMatcher<? super OWLClass> getOWLClassMatcher(String string) throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected static IMatcher<? super OWLObjectProperty> getOWLObjectPropertyMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected static IMatcher<? super OWLDataProperty> getOWLDataPropertyMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected static IMatcher<? super OWLNamedObject> getOWLNamedObjectMatcher(String string)
			throws LiteralFormatException {
		Matcher match = PATTERN_LITERAL.matcher(string);
		if (!match.matches()) {
			throw new LiteralWrongFormatException("Literal [" + string + "] has wrong format. "
					+ "Should be in form either namespace:name, <htt://full.com#name> or ?variable.");
		}
		String fullURI = match.group(PATTERN_LITERAL_FULLIRI_GROUP);
		String prefixedURI = match.group(PATTERN_LITERAL_PREFIXEDIRI_GROUP);
		String variable = match.group(PATTERN_LITERAL_VARIABLE_GROUP);
		if (fullURI != null) {
			String fullIRInamespace = match.group(PATTERN_LITERAL_FULLIRI_NAMESPACE);
			String fullIRIname = match.group(PATTERN_LITERAL_FULLIRI_NAME);
			return new OWLNamedObjectMatcher(IRI.create(fullIRInamespace, fullIRIname));
		} else if (prefixedURI != null) {
			String prefixedIRIprefix = match.group(PATTERN_LITERAL_PREFIXEDIRI_PREFIX);
			String prefix = prefixManager.getPrefix(prefixedIRIprefix);
			if (prefix == null) {
				throw new LiteralUnknownPrefixException(
						"Literal [" + string + "] has wrong format. " + "Prefix [" + prefix + "] is unknown. Use @"
								+ Prefix.class.getName() + " annotation to register not build-in prefixes.");
			}
			String prefixedIRIname = match.group(PATTERN_LITERAL_PREFIXEDIRI_NAME);
			return new OWLNamedObjectMatcher(IRI.create(prefix, prefixedIRIname));
		} else if (variable != null) {
			String variableName = match.group(PATTERN_LITERAL_VARIABLE_VALUE);
			return new VariableMatcher(variableName);
		} else {
			throw new LiteralWrongFormatException("Literal [" + string + "] has wrong format. "
					+ "Should be in form either [namespace:name], [<htt://full.com#name>] or [?variable].");
		}
	}

	protected static IMatcher<? super String> getStringMatcher(String string) {
		if (string == null) {
			return JavaAnyMatcher.getInstance();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return new VariableMatcher(match.group(PATTERN_VARIABLE_NAME));
		} else {
			return new JavaStringMatcher(string);
		}
	}

	/**
	 * <p>
	 * Splits input string into 2 parts separated by whitespaces:
	 * <ol>
	 * <li>Individual template (required, can't be empty);
	 * <li>Class template (required, can't be empty);
	 * </ol>
	 * 
	 * @param string
	 *            input string
	 * @return string array containing Individual and Class template.
	 * @throws AnnotationFormatException
	 *             if input string is not matches by patter, e.g. not in form of
	 *             pair: {@code [<individual_template> <class_template>]}.
	 * @see {@link #PATTERN_CLASS_ASSERTION}
	 */
	protected static String[] splitClassAssertioin(String string) throws AssertionFormatException {
		Matcher match = PATTERN_CLASS_ASSERTION.matcher(string);
		if (!match.matches()) {
			throw new AssertionWrongFormatException("Class Assertion template [" + string + "] has wrong format. "
					+ "Should be in form of pair: [<individual_template> <class_template>]");
		}
		return new String[] { match.group(PATTERN_CLASS_ASSERTION_CLASS),
				match.group(PATTERN_CLASS_ASSERTION_INDIVIDUAL) };
	}

	protected static String[] splitDataPropertyAssertioin(String string) throws AssertionFormatException {
		Matcher match = PATTERN_DATA_PROPERTY_ASSERTION.matcher(string);
		if (!match.matches()) {
			throw new AssertionWrongFormatException(
					"DataProperty Assertioin template [" + string + "] have wrong format. Should be in form of triple: "
							+ "[<individual template> <property template> <data template>]");
		}
		return new String[] { match.group(PATTERN_DATA_PROPERTY_ASSERTION_SUBJECT),
				match.group(PATTERN_DATA_PROPERTY_ASSERTION_PROPERTY),
				match.group(PATTERN_DATA_PROPERTY_ASSERTION_OBJECT) };
	}

	protected static String[] splitObjectPropertyAssertioin(String string) throws AssertionFormatException {
		Matcher match = PATTERN_OBJECT_PROPERTY_ASSERTION.matcher(string);
		if (!match.matches()) {
			throw new AssertionWrongFormatException("ObjectProperty Assertioin template [" + string
					+ "] have wrong format. Should be in form of triple: "
					+ "[<individual template> <property template> <individual template>]");
		}
		return new String[] { match.group(PATTERN_OBJECT_PROPERTY_ASSERTION_SUBJECT),
				match.group(PATTERN_OBJECT_PROPERTY_ASSERTION_PROPERTY),
				match.group(PATTERN_OBJECT_PROPERTY_ASSERTION_OBJECT) };
	}

	/**
	 * <p>
	 * Splits input string into 3 parts:
	 * <ol>
	 * <li>Literal value template (required, but can be empty);
	 * <li>Literal language template (optional);
	 * <li>Literal datatype template (optional);
	 * </ol>
	 * <p>
	 * String should have format: {@code <value> ['@' <language>] ['^^' 
	 * <datatype>]}
	 * <p>
	 * For example for string: [<i>some string@en^^xsd:string</i>]
	 * <ol>
	 * <li><i>some string</i> - is a value;
	 * <li><i>en</i> - is a language;
	 * <li><i>xsd:string</i> - is a datatype;
	 * </ol>
	 * 
	 * @param string
	 *            input string
	 * @return string array containing value, language and datatype parts of
	 *         input string.
	 */
	protected static String[] splitDatatypeLiteral(String string) {
		String value = string;
		String language = null;
		String datatype = null;
		int datatypeIndex = string.lastIndexOf(SEPARATOR_DATATYPE);
		if (datatypeIndex != -1) {
			value = string.substring(0, datatypeIndex);
			datatype = string.substring(datatypeIndex + SEPARATOR_DATATYPE.length(), string.length());
		}
		int languageIndex = value.lastIndexOf(SEPARATOR_LANGUAGE);
		if (languageIndex != -1) {
			language = value.substring(languageIndex + SEPARATOR_LANGUAGE.length(), value.length());
			value = value.substring(0, languageIndex);
		}
		return new String[] { value, language, datatype };
	}

}
