package ru.agentlab.maia.annotation2.converter;

import static org.hamcrest.CoreMatchers.allOf;
import static ru.agentlab.maia.agent.Variable.var;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasClassExpression;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDifferentIndividuals;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasDisjointClasses;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIRI;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.hasIndividual;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isClass;
import static ru.agentlab.maia.hamcrest.owlapi.Matchers.isNamed;

import java.lang.annotation.Annotation;
import java.util.Map;

import org.hamcrest.Matcher;
import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.annotation2.AxiomType;
import ru.agentlab.maia.exception.ConverterException;

public class AxiomAnnotation2AxiomMatcher {

	protected static final String VALUE = "value";

	protected static final String TYPE = "type";

	@SuppressWarnings("unchecked")
	public Matcher<?> getMatcher(Annotation ann, Map<String, Object> variables) throws ConverterException {
		AxiomType type = Util.getMethodValue(ann, TYPE, AxiomType.class);
		String[] args = Util.getMethodValue(ann, VALUE, String[].class);
		checkLength(args, type.getArity());
		int length = args.length;
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
			Matcher<? super OWLClass> classMatcher = getOWLNamedObjectMatcher(args[1], variables);
			Matcher<? super OWLNamedIndividual> individualMatcher = getOWLNamedObjectMatcher(args[0], variables);
			return allOf(hasClassExpression(isClass(classMatcher)), hasIndividual(isNamed(individualMatcher)));
		case DATATYPE_DEFINITION:
			return null;
		case DATA_PROPERTY_ASSERTION:
			return null;
		case DATA_PROPERTY_DOMAIN:
			return null;
		case DATA_PROPERTY_RANGE:
			return null;
		case DECLARATION:
			return null;
		case DIFFERENT_INDIVIDUALS:
			Matcher<? super OWLIndividual>[] differentIndividuals = new Matcher[length];
			for (int i = 0; i < length; i++) {
				differentIndividuals[i] = isNamed(getOWLNamedObjectMatcher(args[i], variables));
			}
			return hasDifferentIndividuals(differentIndividuals);
		case DISJOINT_CLASSES:
			Matcher<? super OWLClassExpression>[] disjointClasses = new Matcher[length];
			for (int i = 0; i < length; i++) {
				disjointClasses[i] = isClass(getOWLNamedObjectMatcher(args[i], variables));
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
			return null;
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
	}

	private void checkLength(String[] args, int length) throws ConverterException {
		if (length == -1) {
			return;
		}
		if (args.length != length) {
			throw new ConverterException("Initial goal for Annotation assertion should contain 3 arguments");
		}
	}

	protected Matcher<? super OWLNamedObject> getOWLNamedObjectMatcher(String string, Map<String, Object> variables) {
		if (string.startsWith("?")) {
			return var(string.substring(1), variables);
		} else {
			IRI iri = IRI.create(string);
			return hasIRI(iri);
		}
	}
}
