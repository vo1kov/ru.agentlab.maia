package ru.agentlab.maia.annotation.belief.converter;

import static org.hamcrest.Matchers.allOf;
import static org.hamcrest.Matchers.anything;
import static org.hamcrest.Matchers.equalTo;
import static ru.agentlab.maia.annotation.Variable.var;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasClassExpression;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDifferentIndividuals;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDisjointClasses;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIRI;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasObject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasSubject;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isBooleanLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDataProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isDoubleLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isFloatLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isIntegerLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamedClass;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamedIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isObjectProperty;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isPlainLiteral;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isTypedLiteral;

import java.lang.annotation.Annotation;
import java.util.Map;
import java.util.Set;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.PrefixManager;
import org.semanticweb.owlapi.util.DefaultPrefixManager;
import org.semanticweb.owlapi.vocab.Namespaces;
import org.semanticweb.owlapi.vocab.OWL2Datatype;

import com.google.common.collect.ImmutableSet;

import ru.agentlab.maia.ConverterContext;
import ru.agentlab.maia.annotation.IEventMatcherConverter;
import ru.agentlab.maia.annotation.Util;
import ru.agentlab.maia.annotation.belief.AxiomType;
import ru.agentlab.maia.exception.ConverterException;

public class OnBeliefXXXConverter implements IEventMatcherConverter {

	private static final String INF_NEG = "-INF";

	private static final String INF = "INF";

	private static final String NaN = "NaN";

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

	PrefixManager prefixManager = new DefaultPrefixManager();

	@SuppressWarnings("unchecked")
	@Override
	public Matcher<?> getMatcher(ConverterContext context) {
		Annotation ann = context.getAnnotation();
		Map<String, Object> variables = context.getVariables();
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

	/**
	 * 
	 * @param string
	 * @param variables
	 * @return
	 * @throws LiteralFormatException
	 */
	protected Matcher<? super OWLLiteral> getOWLLiteralMatcher(String string, Map<String, Object> variables)
			throws LiteralFormatException {
		String[] parts = Util.splitDatatypeLiteral(string);
		String literal = parts[0];
		String language = parts[1];
		String datatype = parts[2];

		if (language != null) {
			return isPlainLiteral(hasString(literal, variables), hasString(language, variables));
		}
		if (datatype != null) {
			if (Util.isVariable(datatype)) {
				return isTypedLiteral(hasString(literal, variables), var(Util.getVariableName(datatype), variables));
			} else {
				IRI datatypeIRI = prefixManager.getIRI(datatype);
				String datatypeNamespace = datatypeIRI.getNamespace();
				if (BUILDIN_DATATYPE_NAMESPACES.contains(datatypeNamespace)) {
					if (!OWL2Datatype.isBuiltIn(datatypeIRI)) {
						throw new LiteralWrongBuildInDatatypeException("Literal [" + string
								+ "] has wrong format. Ontology [" + datatypeNamespace
								+ "] does not contain build-in datatype [" + datatypeIRI.toQuotedString() + "]");
					}
					OWL2Datatype owl2datatype = OWL2Datatype.getDatatype(datatypeIRI);
					if (!Util.isVariable(literal) && !owl2datatype.isInLexicalSpace(literal)) {
						throw new LiteralNotInLexicalSpaceException("Literal [" + string + "] has wrong format. Value ["
								+ literal + "] is not in lexical space of datatype [" + datatypeIRI.toQuotedString()
								+ "]");
					}
					switch (owl2datatype) {
					case XSD_BOOLEAN:
						return isBooleanLiteral(hasBoolean(literal, variables));
					case XSD_FLOAT:
						return isFloatLiteral(hasFloat(literal, variables));
					case XSD_DOUBLE:
						return isDoubleLiteral(hasDouble(literal, variables));
					case XSD_INT:
					case XSD_INTEGER:
						return isIntegerLiteral(hasInteger(literal, variables));
					case RDF_PLAIN_LITERAL:
						return isPlainLiteral(equalTo(literal), equalTo(language));
					default:
						return isTypedLiteral(hasString(literal, variables), hasIRI(datatypeIRI));
					}
				} else {
					return isTypedLiteral(hasString(literal, variables), hasIRI(datatypeIRI));
				}
			}
		}
		return isPlainLiteral(hasString(literal, variables), anything());
	}

	private Matcher<? super OWLNamedObject> hasName(String string, Map<String, Object> variables) {
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
		} else {
			return hasIRI(prefixManager.getIRI(string));
		}
	}

	private Matcher<? super String> hasString(String string, Map<String, Object> variables) {
		if (string == null) {
			return anything();
		}
		if (Util.isVariable(string)) {
			return var(Util.getVariableName(string), variables);
		} else {
			return equalTo(string);
		}
	}

	private Matcher<? super Boolean> hasBoolean(String string, Map<String, Object> variables)
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

	private Matcher<? super Float> hasFloat(String string, Map<String, Object> variables)
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
			} else if (string.equals(INF)) {
				value = Float.POSITIVE_INFINITY;
			} else if (string.equals(INF_NEG)) {
				value = Float.NEGATIVE_INFINITY;
			} else {
				value = Float.parseFloat(string);
			}
			return equalTo(value);
		}
	}

	private Matcher<? super Double> hasDouble(String string, Map<String, Object> variables)
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

	private Matcher<? super Integer> hasInteger(String string, Map<String, Object> variables)
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

	private void checkLength(String[] args, int length) {
		if (length == -1) {
			return;
		}
		if (args.length != length) {
			throw new ConverterException(
					"Initial goal for Annotation assertion should contain " + length + " arguments");
		}
	}
}
