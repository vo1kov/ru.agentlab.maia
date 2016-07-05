package ru.agentlab.maia.role.converter;

import static org.hamcrest.CoreMatchers.allOf;
import static org.hamcrest.CoreMatchers.anything;
import static org.hamcrest.CoreMatchers.equalTo;
import static ru.agentlab.maia.agent.Variable.var;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasClassExpression;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDifferentIndividuals;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDisjointClasses;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIRI;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasObject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasSubject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isBoolean;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDataProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDouble;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isFloat;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isInteger;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamedClass;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamedIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isObjectProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isPlain;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isTyped;

import java.lang.annotation.Annotation;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import com.google.common.collect.ImmutableSet;

import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.role.AxiomType;

public class AxiomAnnotation2AxiomMatcher {

	private static final String INF_NEG = "-INF";

	private static final String INF = "INF";

	private static final String NaN = "NaN";

	private static final String SEPARATOR_LANGUAGE = "@";

	private static final String SEPARATOR_DATATYPE = "^^";

	protected static final String VALUE = "value";

	protected static final String TYPE = "type";

	private static final Set<String> BUILDIN_DATATYPE_NAMESPACES = ImmutableSet.of(
		// @formatter:off
		Namespaces.OWL.toString(),
		Namespaces.RDF.toString(),
		Namespaces.RDFS.toString(),
		Namespaces.XSD.toString()
		// @formatter:on
	);

	@Inject
	PrefixManager prefixManager;

	@SuppressWarnings("unchecked")
	public Matcher<?> getMatcher(Annotation ann, Map<String, Object> variables) throws ConverterException {
		AxiomType type = Util.getMethodValue(ann, TYPE, AxiomType.class);
		String[] args = Util.getMethodValue(ann, VALUE, String[].class);
		checkLength(args, type.getArity());
		int length = args.length;
		try {
			switch (type) {
			case ANNOTATION_ASSERTION:
				return null;
			case ANNOTATION_PROPERTY_DOMAIN:
				return null;
			case ANNOTATION_PROPERTY_RANGE:
				return null;
			case ASYMMETRIC_OBJECT_PROPERTY:
				return null;
			case CLASS_ASSERTION:
				return allOf(hasClassExpression(isNamedClass(hasName(args[1], variables))),
						hasIndividual(isNamedIndividual(hasName(args[0], variables))));
			case DATATYPE_DEFINITION:
				return null;
			case DATA_PROPERTY_ASSERTION:
				return allOf(hasSubject(isNamedIndividual(hasName(args[0], variables))),
						hasProperty(isDataProperty(hasName(args[1], variables))),
						hasObject(isLiteral(getOWLLiteralMatcher(args[2], variables))));
			case DATA_PROPERTY_DOMAIN:
				return null;
			case DATA_PROPERTY_RANGE:
				return null;
			case DECLARATION:
				return null;
			case DIFFERENT_INDIVIDUALS:
				Matcher<? super OWLIndividual>[] differentIndividuals = new Matcher[length];
				for (int i = 0; i < length; i++) {
					differentIndividuals[i] = isNamedIndividual(hasName(args[i], variables));
				}
				return hasDifferentIndividuals(differentIndividuals);
			case DISJOINT_CLASSES:
				Matcher<? super OWLClassExpression>[] disjointClasses = new Matcher[length];
				for (int i = 0; i < length; i++) {
					disjointClasses[i] = isNamedClass(hasName(args[i], variables));
				}
				return hasDisjointClasses(disjointClasses);
			case DISJOINT_DATA_PROPERTIES:
				return null;
			case DISJOINT_OBJECT_PROPERTIES:
				return null;
			case DISJOINT_UNION:
				return null;
			case EQUIVALENT_CLASSES:
				return null;
			case EQUIVALENT_DATA_PROPERTIES:
				return null;
			case EQUIVALENT_OBJECT_PROPERTIES:
				return null;
			case FUNCTIONAL_DATA_PROPERTY:
				return null;
			case FUNCTIONAL_OBJECT_PROPERTY:
				return null;
			case HAS_KEY:
				return null;
			case INVERSE_FUNCTIONAL_OBJECT_PROPERTY:
				return null;
			case INVERSE_OBJECT_PROPERTIES:
				return null;
			case IRREFLEXIVE_OBJECT_PROPERTY:
				return null;
			case NEGATIVE_DATA_PROPERTY_ASSERTION:
				return null;
			case NEGATIVE_OBJECT_PROPERTY_ASSERTION:
				return null;
			case OBJECT_PROPERTY_ASSERTION:
				return allOf(hasSubject(isNamedIndividual(hasName(args[0], variables))),
						hasProperty(isObjectProperty(hasName(args[1], variables))),
						hasObject(isIndividual(isNamedIndividual(hasName(args[2], variables)))));
			case OBJECT_PROPERTY_DOMAIN:
				return null;
			case OBJECT_PROPERTY_RANGE:
				return null;
			case REFLEXIVE_OBJECT_PROPERTY:
				return null;
			case SAME_INDIVIDUAL:
				return null;
			case SUBCLASS_OF:
				return null;
			case SUB_ANNOTATION_PROPERTY_OF:
				return null;
			case SUB_DATA_PROPERTY:
				return null;
			case SUB_OBJECT_PROPERTY:
				return null;
			case SUB_PROPERTY_CHAIN_OF:
				return null;
			case SWRL_RULE:
				throw new UnsupportedOperationException();
			case SYMMETRIC_OBJECT_PROPERTY:
				return null;
			case TRANSITIVE_OBJECT_PROPERTY:
				return null;
			default:
				return null;
			}
		} catch (LiteralFormatException e) {
			throw new ConverterException(e);
		}
	}

	private void checkLength(String[] args, int length) throws ConverterException {
		if (length == -1) {
			return;
		}
		if (args.length != length) {
			throw new ConverterException(
					"Initial goal for Annotation assertion should contain " + length + " arguments");
		}
	}

	protected Matcher<? super OWLNamedObject> hasName(String string, Map<String, Object> variables) {
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
		}
		return hasIRI(prefixManager.getIRI(string));
	}

	/**
	 * 
	 * <!-- @formatter:off -->
	 * literal   X X    X   X    X   X    ...
	 * language  X null var X    X   null ...
	 * datatype  X X    X   null var null ...
	 * <!-- @formatter:on -->
	 * 
	 * @param string
	 * @param variables
	 * @return
	 * @throws LiteralFormatException
	 */
	protected Matcher<? super OWLLiteral> getOWLLiteralMatcher(String string, Map<String, Object> variables)
			throws LiteralFormatException {
		String[] parts = splitDatatypeLiteral(string);
		String literal = parts[0];
		String language = parts[1];
		String datatype = parts[2];

		if (datatype == null) {
			// Plain Literal
			// [static@en] || [static@?lang] || [?val@en] || [?val@?lang]
			if (language == null) {
				if (Util.isVariable(literal)) {
					return isLiteral(var(Util.getVariableName(literal), variables));
				} else {
					return isLiteral(isPlain(equalTo(literal), equalTo(language)));
				}
			} else {
				if (Util.isVariable(literal)) {
					return isLiteral(isPlain(var(Util.getVariableName(literal), variables), equalTo(language)));
				} else {
					return isLiteral(isPlain(equalTo(literal), equalTo(language)));
				}
			}
		}
		if (datatype != null) {
			if (Util.isVariable(datatype)) {
				return isTyped(equalTo(literal), var(Util.getVariableName(datatype), variables));
			} else {
				IRI datatypeIRI = prefixManager.getIRI(string);
				if (language != null && language.startsWith("?")
						&& !datatypeIRI.equals(OWL2Datatype.RDF_PLAIN_LITERAL.getIRI())) {
					throw new LiteralIllelgalLanguageTagException(
							"Cannot build a literal matcher with type: " + datatypeIRI + " and language: " + language
									+ ". Only " + OWL2Datatype.RDF_PLAIN_LITERAL.getIRI() + " can use language tag.");
				}
				return isLiteral(isPlain(equalTo(literal), equalTo(language)));
			}
		}
		throw new LiteralWrongFormatException("Literal [" + datatype + "] has wrong format. "
				+ "Should be in form either namespace:name, <htt://full.com#name> or ?variable.");

		if (datatype == null) {
			// return isLiteral(isPlain(equalTo(literal), equalTo(language)));
		} else {
			// Typed Literal
			// [static^^some:type] || [static^^?type] || [?val^^some:type] ||
			// [?val^^?type]
			// Matcher match = PATTERN_LITERAL.matcher(datatype);
			// if (!match.matches()) {
			//
			// }
			String variableName = getOWLNamedObjectVariableName(match);
			if (variableName != null) {
				// [static^^?type] || [?val^^?type]
				return isTyped(equalTo(literal), var(variableName, variables));
			} else {
				// [static^^some:type] || [?val^^some:type]
				// IRI datatypeIRI = getOWLNamedObjectIRI(match);
				// if (language != null && language.startsWith("?")
				// &&
				// !datatypeIRI.equals(OWL2Datatype.RDF_PLAIN_LITERAL.getIRI()))
				// {
				// throw new LiteralIllelgalLanguageTagException(
				// "Cannot build a literal matcher with type: " + datatypeIRI +
				// " and language: " + language
				// + ". Only " + OWL2Datatype.RDF_PLAIN_LITERAL.getIRI() + " can
				// use language tag.");
				// }
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
						return isBoolean(getBooleanMatcher(literal, variables));
					case XSD_FLOAT:
						return isFloat(getFloatMatcher(literal, variables));
					case XSD_DOUBLE:
						return isDouble(getDoubleMatcher(literal, variables));
					case XSD_INT:
					case XSD_INTEGER:
						return isInteger(getIntegerMatcher(literal, variables));
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
	}

	protected Matcher<? super String> getStringMatcher(String string, Map<String, Object> variables) {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
		} else {
			return equalTo(string);
		}
	}

	protected Matcher<? super Boolean> getBooleanMatcher(String string, Map<String, Object> variables)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
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

	private Matcher<? super Float> getFloatMatcher(String string, Map<String, Object> variables)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
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

	private Matcher<? super Double> getDoubleMatcher(String string, Map<String, Object> variables)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
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

	private Matcher<? super Integer> getIntegerMatcher(String string, Map<String, Object> variables)
			throws LiteralNotInValueSpaceException {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
		} else {
			return equalTo(Integer.parseInt(string));
		}
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
