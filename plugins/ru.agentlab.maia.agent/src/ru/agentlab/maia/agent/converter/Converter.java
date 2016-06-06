package ru.agentlab.maia.agent.converter;

import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.CoreMatchers.anyOf;
import static org.hamcrest.CoreMatchers.anything;
import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static ru.agentlab.maia.agent.Variable.var;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasContent;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasConversationId;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasEncoding;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasInReplyTo;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasLanguage;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasOntology;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasPerformative;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasProtocol;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasReplyWith;
import static ru.agentlab.maia.hamcrest.message.Matchers.hasSender;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasClassExpression;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIRI;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasObject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasSubject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isBoolean;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isClass;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDataProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDouble;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isFloat;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isInteger;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamed;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isObjectProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isPlain;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isTyped;

import java.lang.annotation.Annotation;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Stream;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import com.google.common.collect.ImmutableSet;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IConverter;
import ru.agentlab.maia.IInjector;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.PlanStateful;
import ru.agentlab.maia.agent.PlanStateles;
import ru.agentlab.maia.annotation.BeliefClassificationAdded;
import ru.agentlab.maia.annotation.BeliefClassificationRemoved;
import ru.agentlab.maia.annotation.BeliefDataPropertyAdded;
import ru.agentlab.maia.annotation.BeliefDataPropertyRemoved;
import ru.agentlab.maia.annotation.BeliefObjectPropertyAdded;
import ru.agentlab.maia.annotation.BeliefObjectPropertyRemoved;
import ru.agentlab.maia.annotation.EventMatcher;
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
import ru.agentlab.maia.annotation.event.AddedExternalEvent;
import ru.agentlab.maia.annotation.event.AddedMessage;
import ru.agentlab.maia.annotation.event.AddedRole;
import ru.agentlab.maia.annotation.event.RemovedMessage;
import ru.agentlab.maia.annotation.event.RemovedRole;
import ru.agentlab.maia.annotation.event.ResolvedRole;
import ru.agentlab.maia.annotation.event.UnhandledMessage;
import ru.agentlab.maia.annotation.event.UnresolvedRole;
import ru.agentlab.maia.exception.ConverterException;

public class Converter implements IConverter {

	private static final String INF_NEG = "-INF";

	private static final String INF = "INF";

	private static final String NaN = "NaN";

	private static final String METHOD_NAME = "value";

	private static final String SEPARATOR_LANGUAGE = "@";

	private static final String SEPARATOR_DATATYPE = "^^";

	// @formatter:off
	private static final Set<Class<?>> ANNOTATIONS_CLASSIFICATION_ASSERTION = ImmutableSet.of(
		BeliefClassificationAdded.class,
		BeliefClassificationRemoved.class, 
		GoalClassificationAdded.class, 
		GoalClassificationFailed.class,
		GoalClassificationFinished.class, 
		GoalClassificationRemoved.class
	);
	private static final Set<Class<?>> ANNOTATIONS_DATA_PROPERTY_ASSERTION = ImmutableSet.of(
		BeliefDataPropertyAdded.class,
		BeliefDataPropertyRemoved.class, 
		GoalDataPropertyAdded.class, 
		GoalDataPropertyFailed.class,
		GoalDataPropertyFinished.class, 
		GoalDataPropertyRemoved.class
	);
	private static final Set<Class<?>> ANNOTATIONS_OBJECT_PROPERTY_ASSERTION = ImmutableSet.of(
		BeliefObjectPropertyAdded.class,
		BeliefObjectPropertyRemoved.class, 
		GoalObjectPropertyAdded.class, 
		GoalObjectPropertyFailed.class,
		GoalObjectPropertyFinished.class, 
		GoalObjectPropertyRemoved.class
	);
//	private static final Set<Class<?>> ANNOTATIONS_METHOD = ImmutableSet.of(
//		PlanAdded.class,
//		PlanFailed.class, 
//		PlanFinished.class, 
//		PlanRemoved.class
//	);
	private static final Set<Class<?>> ANNOTATIONS_CLASS = ImmutableSet.of(
		AddedRole.class,
		RemovedRole.class, 
		ResolvedRole.class, 
		UnresolvedRole.class,
		AddedExternalEvent.class
	);
	private static final Set<Class<?>> ANNOTATIONS_MESSAGE = ImmutableSet.of(
		AddedMessage.class,
		RemovedMessage.class, 
		UnhandledMessage.class
	);
	private static Set<String> BUILDIN_DATATYPE_NAMESPACES = ImmutableSet.of(
		Namespaces.OWL.toString(),
		Namespaces.RDF.toString(),
		Namespaces.RDFS.toString(),
		Namespaces.XSD.toString()
	);
	// @formatter:on

	protected static final String REGEXP_LITERAL_PREFIXED = "((\\w*:)?(\\S+))";

	protected static final String REGEXP_LITERAL_FULL = "(<(\\S+#)(\\S+)>)";

	protected static final String REGEXP_VARIABLE = "(\\?(\\w+))";

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
	protected static final Pattern PATTERN_DATA_PROPERTY_ASSERTION = Pattern
			.compile("(?s)^\\s*(\\S+)\\s+(\\S+)\\s+(\\S.*)$");
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

	protected static final Pattern PATTERN_METHOD = Pattern.compile("^\\s*?(\\S+)\\s*?::\\s*?(\\S+)\\s*?$");
	protected static final int PATTERN_METHOD_CLASS = 1;
	protected static final int PATTERN_METHOD_NAME = 2;

	protected PrefixManager prefixManager = new DefaultPrefixManager();

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * ru.agentlab.maia.agent.converter.IConverter#getPlans(java.lang.Object)
	 */
	@Override
	public Map<IPlan, EventType> getInitialPlans(Object role, IInjector injector) throws ConverterException {
		Map<IPlan, EventType> registrations = new HashMap<>();
		try {
			Method[] methods = role.getClass().getMethods();
			for (Method method : methods) {
				Optional<Annotation> eventAnnotation = Stream.of(method.getAnnotations())
						.filter(ann -> ann.annotationType().isAnnotationPresent(EventMatcher.class)).findFirst();
				if (!eventAnnotation.isPresent()) {
					continue;
				}
				Annotation ann = eventAnnotation.get();
				EventType type = ann.annotationType().getAnnotation(EventMatcher.class).value();
				IPlan plan;
				if (method.getParameterCount() == 0) {
					plan = new PlanStateles(role, method);
				} else {
					plan = new PlanStateful(role, method);
				}
				plan.setEventMatcher(getEventMatcher(ann));
				registrations.put(plan, type);
			}
			return registrations;
		} catch (AnnotationFormatException e) {
			throw new ConverterException(e);
		}
	}

	@Override
	public List<OWLAxiom> getInitialBeliefs(Object role) throws ConverterException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OWLAxiom> getInitialGoals(Object role) throws ConverterException {
		// TODO Auto-generated method stub
		return null;
	}

	protected org.hamcrest.Matcher<?> getEventMatcher(Annotation ann) throws AnnotationFormatException {
		if (ANNOTATIONS_CLASSIFICATION_ASSERTION.contains(ann.annotationType())) {
			String value = getMethodValue(ann, METHOD_NAME, String.class);
			return getOWLClassAssertionAxiomMatcher(value);
		} else if (ANNOTATIONS_DATA_PROPERTY_ASSERTION.contains(ann.annotationType())) {
			String value = getMethodValue(ann, METHOD_NAME, String.class);
			return getOWLDataPropertyAssertionAxiomMatcher(value);
		} else if (ANNOTATIONS_OBJECT_PROPERTY_ASSERTION.contains(ann.annotationType())) {
			String value = getMethodValue(ann, METHOD_NAME, String.class);
			return getOWLObjectPropertyAssertionAxiomMatcher(value);
			// } else if (ANNOTATIONS_METHOD.contains(ann.annotationType())) {
			// String value = getMethodValue(ann, METHOD_NAME, String.class);
			// return getJavaMethodMatcher(value);
		} else if (ANNOTATIONS_CLASS.contains(ann.annotationType())) {
			Class<?> value = getMethodValue(ann, METHOD_NAME, Class.class);
			return anyOf(instanceOf(value), equalTo(value));
		} else if (ANNOTATIONS_MESSAGE.contains(ann.annotationType())) {
			return getMessageMatcher(ann);
		} else {
			throw new RuntimeException();
		}
	}

	protected org.hamcrest.Matcher<? super IMessage> getMessageMatcher(Annotation ann) {
		List<org.hamcrest.Matcher<? super IMessage>> matchers = new ArrayList<>();
		String performative = getMethodValue(ann, "performative", String.class);
		if (!performative.equals("")) {
			matchers.add(hasPerformative(equalTo(performative)));
		}
		String sender = getMethodValue(ann, "sender", String.class);
		if (!sender.equals("")) {
			matchers.add(hasSender(equalTo(UUID.fromString(sender))));
		}
		org.hamcrest.Matcher<? super List<UUID>> receiversMatcher;
		org.hamcrest.Matcher<? super List<UUID>> replyToMatcher;

		String content = getMethodValue(ann, "content", String.class);
		if (!content.equals("")) {
			matchers.add(hasContent(equalTo(performative)));
		}
		String replyWith = getMethodValue(ann, "replyWith", String.class);
		if (!replyWith.equals("")) {
			matchers.add(hasReplyWith(equalTo(performative)));
		}
		String inReplyTo = getMethodValue(ann, "inReplyTo", String.class);
		if (!inReplyTo.equals("")) {
			matchers.add(hasInReplyTo(equalTo(performative)));
		}
		String encoding = getMethodValue(ann, "encoding", String.class);
		if (!encoding.equals("")) {
			matchers.add(hasEncoding(equalTo(performative)));
		}
		String language = getMethodValue(ann, "language", String.class);
		if (!language.equals("")) {
			matchers.add(hasLanguage(equalTo(performative)));
		}
		String ontology = getMethodValue(ann, "ontology", String.class);
		if (!ontology.equals("")) {
			matchers.add(hasOntology(equalTo(performative)));
		}
		org.hamcrest.Matcher<? super LocalDateTime> replyByMatcher;
		String protocol = getMethodValue(ann, "protocol", String.class);
		if (!protocol.equals("")) {
			matchers.add(hasProtocol(equalTo(performative)));
		}
		String conversationId = getMethodValue(ann, "conversationId", String.class);
		if (!conversationId.equals("")) {
			matchers.add(hasConversationId(equalTo(performative)));
		}
		org.hamcrest.Matcher<? super LocalDateTime> postTimeStampMatcher;
		return allOf(matchers.toArray(new org.hamcrest.Matcher[matchers.size()]));
	}

	// protected JavaMethodMatcher getJavaMethodMatcher(String value) throws
	// MethodWrongFormatException {
	// Matcher match = PATTERN_METHOD.matcher(value);
	// if (!match.matches()) {
	// throw new MethodWrongFormatException();
	// }
	// String clazzName = match.group(PATTERN_METHOD_CLASS);
	// String methodName = match.group(PATTERN_METHOD_NAME);
	// try {
	// Class<?> clazz = Class.forName(clazzName);
	// Optional<Method> method =
	// Stream.of(clazz.getMethods()).filter(methodName::equals).findFirst();
	// if (!method.isPresent()) {
	// throw new MethodWrongFormatException();
	// }
	// return new JavaMethodMatcher(method.get());
	// } catch (ClassNotFoundException e) {
	// throw new MethodWrongFormatException();
	// }
	// }

	// protected JavaClassMatcher getJavaClassMatcher(Class<?> value) {
	// return new JavaClassMatcher(value);
	// }

	private static <T> T getMethodValue(Object object, String methodName, Class<T> clazz) {
		try {
			Method valueMethod = object.getClass().getMethod(methodName);
			Object result = valueMethod.invoke(object);
			return clazz.cast(result);
		} catch (NoSuchMethodException | SecurityException | IllegalAccessException | IllegalArgumentException
				| InvocationTargetException e) {
			e.printStackTrace();
			return null;
		}
	}

	protected org.hamcrest.Matcher<? super OWLClassAssertionAxiom> getOWLClassAssertionAxiomMatcher(String template)
			throws AnnotationFormatException {
		String[] parts = splitClassAssertioin(template);
		String individual = parts[0];
		String clazz = parts[1];
		return allOf(hasClassExpression(isClass(getOWLNamedObjectMatcher(clazz))),
				hasIndividual(isNamed(getOWLNamedObjectMatcher(individual))));
		// return new OWLClassAssertionAxiomMatcher(getOWLClassMatcher(clazz),
		// getOWLNamedIndividualMatcher(individual));
	}

	protected org.hamcrest.Matcher<? super OWLDataPropertyAssertionAxiom> getOWLDataPropertyAssertionAxiomMatcher(
			String template) throws AnnotationFormatException {
		String[] parts = splitDataPropertyAssertioin(template);
		String subject = parts[0];
		String property = parts[1];
		String data = parts[2];

		return allOf(hasSubject(isNamed(getOWLNamedObjectMatcher(subject))),
				hasProperty(isDataProperty(getOWLNamedObjectMatcher(property))),
				hasObject(isLiteral(getOWLLiteralMatcher(data))));

		// return new
		// OWLDataPropertyAssertionAxiomMatcher(getOWLNamedIndividualMatcher(subject),
		// getOWLDataPropertyMatcher(property), getOWLLiteralMatcher(object));
	}

	protected org.hamcrest.Matcher<? super OWLObjectPropertyAssertionAxiom> getOWLObjectPropertyAssertionAxiomMatcher(
			String template) throws AnnotationFormatException {
		String[] parts = splitObjectPropertyAssertioin(template);
		String subject = parts[0];
		String property = parts[1];
		String object = parts[2];
		return allOf(hasSubject(isNamed(getOWLNamedObjectMatcher(subject))),
				hasProperty(isObjectProperty(getOWLNamedObjectMatcher(property))),
				hasObject(isIndividual(isNamed(getOWLNamedObjectMatcher(object)))));
		// return new
		// OWLObjectPropertyAssertionAxiomMatcher(getOWLNamedIndividualMatcher(subject),
		// getOWLObjectPropertyMatcher(property),
		// getOWLNamedIndividualMatcher(data));
	}

	protected org.hamcrest.Matcher<? super OWLLiteral> getOWLLiteralMatcher(String string)
			throws LiteralFormatException {
		String[] parts = splitDatatypeLiteral(string);
		String literal = parts[0];
		String language = parts[1];
		String datatype = parts[2];
		if (datatype == null) {
			// Plain Literal
			// [static@en] || [static@?lang] || [?val@en] || [?val@?lang]
			return isLiteral(isPlain(equalTo(literal), equalTo(language)));
		} else {
			// Typed Literal
			// [static^^some:type] || [static^^?type] || [?val^^some:type] ||
			// [?val^^?type]
			Matcher match = PATTERN_LITERAL.matcher(datatype);
			if (!match.matches()) {
				throw new LiteralWrongFormatException("Literal [" + datatype + "] has wrong format. "
						+ "Should be in form either namespace:name, <htt://full.com#name> or ?variable.");
			}
			String variableName = getOWLNamedObjectVariableName(match);
			if (variableName != null) {
				// [static^^?type] || [?val^^?type]
				return isTyped(equalTo(literal), var(variableName, Collections.emptyMap()));
			} else {
				// [static^^some:type] || [?val^^some:type]
				IRI datatypeIRI = getOWLNamedObjectIRI(match);
				if (language != null && language.startsWith("?")
						&& !datatypeIRI.equals(OWL2Datatype.RDF_PLAIN_LITERAL.getIRI())) {
					throw new LiteralIllelgalLanguageTagException(
							"Cannot build a literal matcher with type: " + datatypeIRI + " and language: " + language
									+ ". Only " + OWL2Datatype.RDF_PLAIN_LITERAL.getIRI() + " can use language tag.");
				}
				String datatypeNamespace = datatypeIRI.getNamespace();
				if (BUILDIN_DATATYPE_NAMESPACES.contains(datatypeNamespace)) {
					if (!OWL2Datatype.isBuiltIn(datatypeIRI)) {
						throw new LiteralWrongBuildInDatatypeException("Literal [" + string
								+ "] has wrong format. Ontology [" + datatypeNamespace
								+ "] does not contain build-in datatype [" + datatypeIRI.toQuotedString() + "]");
					}
					OWL2Datatype owl2datatype = OWL2Datatype.getDatatype(datatypeIRI);
					// if value is not variable then check lexical space
					if (!literal.startsWith("?") && !owl2datatype.isInLexicalSpace(literal)) {
						throw new LiteralNotInLexicalSpaceException("Literal [" + string + "] has wrong format. Value ["
								+ literal + "] is not in lexical space of datatype [" + datatypeIRI.toQuotedString()
								+ "]");
					}
					switch (owl2datatype) {
					case XSD_BOOLEAN:
						return isBoolean(getBooleanMatcher(literal));
					case XSD_FLOAT:
						return isFloat(getFloatMatcher(literal));
					case XSD_DOUBLE:
						return isDouble(getDoubleMatcher(literal));
					case XSD_INT:
					case XSD_INTEGER:
						return isInteger(getIntegerMatcher(literal));
					case RDF_PLAIN_LITERAL:
						return isLiteral(isPlain(equalTo(literal), equalTo(language)));
					default:
						break;
					}
				}
				return isTyped(equalTo(language == null ? literal : literal + SEPARATOR_LANGUAGE + language),
						hasIRI(datatypeIRI));
			}
		}
		// IMatcher<? super OWLDatatype> datatypeMatcher =
		// getOWLDatatypeMatcher(datatype);
		// IMatcher<? super String> literalMatcher = getStringMatcher(literal);
		// IMatcher<? super String> languageMatcher =
		// getStringMatcher(language);
		// if ((datatypeMatcher instanceof OWLNamedObjectMatcher)) {
		// IRI datatypeIRI = ((OWLNamedObjectMatcher)
		// datatypeMatcher).getValue();
		// String datatypeNamespace = datatypeIRI.getNamespace();
		// if (BUILDIN_DATATYPE_NAMESPACES.contains(datatypeNamespace)) {
		// if (OWL2Datatype.isBuiltIn(datatypeIRI)) {
		// OWL2Datatype owl2datatype = OWL2Datatype.getDatatype(datatypeIRI);
		// if (!(literalMatcher instanceof VariableMatcher) &&
		// !owl2datatype.isInLexicalSpace(literal)) {
		// throw new LiteralNotInLexicalSpaceException("Literal [" + string + "]
		// has wrong format. Value ["
		// + literal + "] is not in lexical space of datatype [" +
		// datatypeIRI.toQuotedString()
		// + "]");
		// }
		// } else {
		// throw new LiteralWrongBuildInDatatypeException(
		// "Literal [" + string + "] has wrong format. Ontology [" +
		// datatypeNamespace
		// + "] does not contain build-in datatype [" +
		// datatypeIRI.toQuotedString() + "]");
		// }
		// }
		// }
		// return new OWLLiteralPlainMatcher(literalMatcher, languageMatcher,
		// datatypeMatcher);
	}

	// protected org.hamcrest.Matcher<? super OWLDatatype>
	// getOWLDatatypeMatcher(String string)
	// throws LiteralFormatException {
	// if (string == null) {
	// return new
	// OWLNamedObjectMatcher(OWL2Datatype.RDF_PLAIN_LITERAL.getIRI());
	// }
	// return getOWLNamedObjectMatcher(string);
	// }

	protected org.hamcrest.Matcher<? super OWLNamedIndividual> getOWLNamedIndividualMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected org.hamcrest.Matcher<? super OWLClass> getOWLClassMatcher(String string) throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected org.hamcrest.Matcher<? super OWLObjectProperty> getOWLObjectPropertyMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected org.hamcrest.Matcher<? super OWLDataProperty> getOWLDataPropertyMatcher(String string)
			throws LiteralFormatException {
		return getOWLNamedObjectMatcher(string);
	}

	protected org.hamcrest.Matcher<? super OWLNamedObject> getOWLNamedObjectMatcher(String string)
			throws LiteralFormatException {
		Matcher match = PATTERN_LITERAL.matcher(string);
		if (!match.matches()) {
			throw new LiteralWrongFormatException("Literal [" + string + "] has wrong format. "
					+ "Should be in form either namespace:name, <htt://full.com#name> or ?variable.");
		}
		String variableName = getOWLNamedObjectVariableName(match);
		if (variableName != null) {
			return var(variableName, Collections.emptyMap());
		}
		IRI iri = getOWLNamedObjectIRI(match);
		return hasIRI(iri);
	}

	private String getOWLNamedObjectVariableName(Matcher match) {
		if (match.group(PATTERN_LITERAL_VARIABLE_GROUP) != null) {
			return match.group(PATTERN_LITERAL_VARIABLE_VALUE);
		} else {
			return null;
		}
	}

	private IRI getOWLNamedObjectIRI(Matcher match) throws LiteralUnknownPrefixException {
		if (match.group(PATTERN_LITERAL_FULLIRI_GROUP) != null) {
			String fullIRInamespace = match.group(PATTERN_LITERAL_FULLIRI_NAMESPACE);
			String fullIRIname = match.group(PATTERN_LITERAL_FULLIRI_NAME);
			return IRI.create(fullIRInamespace, fullIRIname);
		} else if (match.group(PATTERN_LITERAL_PREFIXEDIRI_GROUP) != null) {
			String prefixedIRIprefix = match.group(PATTERN_LITERAL_PREFIXEDIRI_PREFIX);
			String prefix = prefixManager.getPrefix(prefixedIRIprefix);
			if (prefix == null) {
				throw new LiteralUnknownPrefixException("Prefix [" + prefix + "] is unknown. Use @"
						+ Prefix.class.getName() + " annotation to register not build-in prefixes.");
			}
			String prefixedIRIname = match.group(PATTERN_LITERAL_PREFIXEDIRI_NAME);
			return IRI.create(prefix, prefixedIRIname);
		} else {
			throw new RuntimeException();
		}
	}

	protected org.hamcrest.Matcher<? super String> getStringMatcher(String string) {
		if (string == null) {
			return anything();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return var(match.group(PATTERN_VARIABLE_NAME), Collections.emptyMap());
		} else {
			return equalTo(string);
		}
	}

	protected org.hamcrest.Matcher<? super Boolean> getBooleanMatcher(String string)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return var(match.group(PATTERN_VARIABLE_NAME), Collections.emptyMap());
		} else {
			boolean value;
			if (string.equals("true") || string.equals("1")) {
				value = true;
			} else if (string.equals("false") || string.equals("0")) {
				value = false;
			} else {
				throw new LiteralNotInValueSpaceException("Argument should be [true|false|1|0]");
			}
			return equalTo(value);
		}
	}

	private org.hamcrest.Matcher<? super Float> getFloatMatcher(String string) throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return var(match.group(PATTERN_VARIABLE_NAME), Collections.emptyMap());
		} else {
			float value;
			if (string.equals(NaN)) {
				value = Float.NaN;
			}
			if (string.equals(INF)) {
				value = Float.POSITIVE_INFINITY;
			}
			if (string.equals(INF_NEG)) {
				value = Float.NEGATIVE_INFINITY;
			} else {
				value = Float.parseFloat(string);
			}
			return equalTo(value);
		}
	}

	private org.hamcrest.Matcher<? super Double> getDoubleMatcher(String string)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return var(match.group(PATTERN_VARIABLE_NAME), Collections.emptyMap());
		} else {
			double value;
			if (string.equals(NaN)) {
				value = Double.NaN;
			}
			if (string.equals(INF)) {
				value = Double.POSITIVE_INFINITY;
			}
			if (string.equals(INF_NEG)) {
				value = Double.NEGATIVE_INFINITY;
			} else {
				value = Double.parseDouble(string);
			}
			return equalTo(value);
		}
	}

	private org.hamcrest.Matcher<? super Integer> getIntegerMatcher(String string)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		Matcher match = PATTERN_VARIABLE.matcher(string);
		if (match.matches()) {
			return var(match.group(PATTERN_VARIABLE_NAME), Collections.emptyMap());
		} else {
			return equalTo(Integer.parseInt(string));
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
	protected String[] splitClassAssertioin(String string) throws AssertionFormatException {
		Matcher match = PATTERN_CLASS_ASSERTION.matcher(string);
		if (!match.matches()) {
			throw new AssertionWrongFormatException("Class Assertion template [" + string + "] has wrong format. "
					+ "Should be in form of pair: [<individual_template> <class_template>]");
		}
		return new String[] { match.group(PATTERN_CLASS_ASSERTION_CLASS),
				match.group(PATTERN_CLASS_ASSERTION_INDIVIDUAL) };
	}

	protected String[] splitDataPropertyAssertioin(String string) throws AssertionFormatException {
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

	protected String[] splitObjectPropertyAssertioin(String string) throws AssertionFormatException {
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
	protected String[] splitDatatypeLiteral(String string) {
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
