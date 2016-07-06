package ru.agentlab.maia.role.converter;

import java.lang.annotation.Annotation;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLOntologyManager;
import org.semanticweb.owlapi.model.PrefixManager;

import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.role.AxiomType;

public class AxiomAnnotation2AxiomInstance {

	@Inject
	OWLOntologyManager manager;

	@Inject
	OWLDataFactory factory;

	@Inject
	PrefixManager prefixManager;

	public OWLAxiom getAxiom(Annotation ann) throws ConverterException {
		AxiomType type = Util.getMethodValue(ann, "type", AxiomType.class);
		String[] args = Util.getMethodValue(ann, "value", String[].class);
		checkNoVariables(args);
		checkLength(args, type.getArity());
		switch (type) {
		// @formatter:off
		case ANNOTATION_ASSERTION:
			// TODO: value can be literal
			return factory.getOWLAnnotationAssertionAxiom(
					factory.getOWLAnnotationProperty(prefixManager.getIRI(args[0])), 
					prefixManager.getIRI(args[1]),
					prefixManager.getIRI(args[2]));
		case ANNOTATION_PROPERTY_DOMAIN:
			return factory.getOWLAnnotationPropertyDomainAxiom(
					factory.getOWLAnnotationProperty(prefixManager.getIRI(args[0])), 
					prefixManager.getIRI(args[1]));
		case ANNOTATION_PROPERTY_RANGE:
			return factory.getOWLAnnotationPropertyRangeAxiom(
					factory.getOWLAnnotationProperty(prefixManager.getIRI(args[0])), 
					prefixManager.getIRI(args[1]));
		case ASYMMETRIC_OBJECT_PROPERTY:
			return factory.getOWLAsymmetricObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case CLASS_ASSERTION:
			return factory.getOWLClassAssertionAxiom(
					factory.getOWLClass(prefixManager.getIRI(args[0])),
					factory.getOWLNamedIndividual(prefixManager.getIRI(args[1])));
		case DATATYPE_DEFINITION:
			// TODO:
			return factory.getOWLDatatypeDefinitionAxiom(
					factory.getOWLDatatype(prefixManager.getIRI(args[0])),
					factory.getOWLDatatype(prefixManager.getIRI(args[1])));
		case DATA_PROPERTY_ASSERTION:
			getOWLLiteral(args[2]);
//			return factory.getOWLDataPropertyAssertionAxiom(
//					factory.getOWLDataProperty(prefixManager.getIRI(args[1])),
//					factory.getOWLNamedIndividual(prefixManager.getIRI(args[0])),
//					factory.getOWLLiteral(lexicalValue, datatype)(prefixManager.getIRI(args[2])));
			return null;
		case DATA_PROPERTY_DOMAIN:
			return factory.getOWLDataPropertyDomainAxiom(
					factory.getOWLDataProperty(prefixManager.getIRI(args[0])),
					factory.getOWLClass(prefixManager.getIRI(args[1])));
		case DATA_PROPERTY_RANGE:
			return factory.getOWLDataPropertyRangeAxiom(
					factory.getOWLDataProperty(prefixManager.getIRI(args[0])),
					factory.getOWLDatatype(prefixManager.getIRI(args[1])));
		case DECLARATION:
			return null;
		case DIFFERENT_INDIVIDUALS:
			Set<OWLIndividual> differentIndividuals = new HashSet<>();
			for (String arg : args) {
				differentIndividuals.add(factory.getOWLNamedIndividual(prefixManager.getIRI(arg)));
			}
			return factory.getOWLDifferentIndividualsAxiom(differentIndividuals);
		case DISJOINT_CLASSES:
			Set<OWLClass> disjointClasses = new HashSet<>();
			for (String arg : args) {
				disjointClasses.add(factory.getOWLClass(prefixManager.getIRI(arg)));
			}
			return factory.getOWLDisjointClassesAxiom(disjointClasses);
		case DISJOINT_DATA_PROPERTIES:
			Set<OWLDataProperty> disjointDataProperties = new HashSet<>();
			for (String arg : args) {
				disjointDataProperties.add(factory.getOWLDataProperty(prefixManager.getIRI(arg)));
			}
			return factory.getOWLDisjointDataPropertiesAxiom(disjointDataProperties);
		case DISJOINT_OBJECT_PROPERTIES:
			Set<OWLObjectProperty> disjointObjectProperties = new HashSet<>();
			for (String arg : args) {
				disjointObjectProperties.add(factory.getOWLObjectProperty(prefixManager.getIRI(arg)));
			}
			return factory.getOWLDisjointObjectPropertiesAxiom(disjointObjectProperties);
		case DISJOINT_UNION:
			Set<OWLClassExpression> classExpressions = new HashSet<>();
			for (int i = 1; i < args.length; i++) {
				classExpressions.add(factory.getOWLClass(prefixManager.getIRI(args[i])));
			}
			return factory.getOWLDisjointUnionAxiom(factory.getOWLClass(prefixManager.getIRI(args[0])),
					classExpressions);
		case EQUIVALENT_CLASSES:
			Set<OWLClass> equivalentClasses = new HashSet<>();
			for (String arg : args) {
				equivalentClasses.add(factory.getOWLClass(prefixManager.getIRI(arg)));
			}
			return factory.getOWLEquivalentClassesAxiom(equivalentClasses);
		case EQUIVALENT_DATA_PROPERTIES:
			Set<OWLDataProperty> equivalentDataProperties = new HashSet<>();
			for (String arg : args) {
				equivalentDataProperties.add(factory.getOWLDataProperty(prefixManager.getIRI(arg)));
			}
			return factory.getOWLEquivalentDataPropertiesAxiom(equivalentDataProperties);
		case EQUIVALENT_OBJECT_PROPERTIES:
			Set<OWLObjectProperty> equivalentObjectProperties = new HashSet<>();
			for (String arg : args) {
				equivalentObjectProperties.add(factory.getOWLObjectProperty(prefixManager.getIRI(arg)));
			}
			return factory.getOWLEquivalentObjectPropertiesAxiom(equivalentObjectProperties);
		case FUNCTIONAL_DATA_PROPERTY:
			return factory.getOWLFunctionalDataPropertyAxiom(
					factory.getOWLDataProperty(prefixManager.getIRI(args[0])));
		case FUNCTIONAL_OBJECT_PROPERTY:
			return factory.getOWLFunctionalObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case HAS_KEY:
			return null;
		case INVERSE_FUNCTIONAL_OBJECT_PROPERTY:
			return factory.getOWLInverseFunctionalObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case INVERSE_OBJECT_PROPERTIES:
			return null;
		case IRREFLEXIVE_OBJECT_PROPERTY:
			return factory.getOWLIrreflexiveObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case NEGATIVE_DATA_PROPERTY_ASSERTION:
			return null;
		case NEGATIVE_OBJECT_PROPERTY_ASSERTION:
			return factory.getOWLNegativeObjectPropertyAssertionAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[1])),
					factory.getOWLNamedIndividual(prefixManager.getIRI(args[0])),
					factory.getOWLNamedIndividual(prefixManager.getIRI(args[2])));
		case OBJECT_PROPERTY_ASSERTION:
			return factory.getOWLObjectPropertyAssertionAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[1])),
					factory.getOWLNamedIndividual(prefixManager.getIRI(args[0])),
					factory.getOWLNamedIndividual(prefixManager.getIRI(args[2])));
		case OBJECT_PROPERTY_DOMAIN:
			return factory.getOWLObjectPropertyDomainAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])),
					factory.getOWLClass(prefixManager.getIRI(args[1])));
		case OBJECT_PROPERTY_RANGE:
			return factory.getOWLObjectPropertyRangeAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])),
					factory.getOWLClass(prefixManager.getIRI(args[1])));
		case REFLEXIVE_OBJECT_PROPERTY:
			return factory.getOWLReflexiveObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case SAME_INDIVIDUAL:
			Set<OWLIndividual> sameIndividuals = new HashSet<>();
			for (String arg : args) {
				sameIndividuals.add(factory.getOWLNamedIndividual(prefixManager.getIRI(arg)));
			}
			return factory.getOWLSameIndividualAxiom(sameIndividuals);
		case SUBCLASS_OF:
			return factory.getOWLSubClassOfAxiom(
					factory.getOWLClass(prefixManager.getIRI(args[0])),
					factory.getOWLClass(prefixManager.getIRI(args[1])));
		case SUB_ANNOTATION_PROPERTY_OF:
			return factory.getOWLSubAnnotationPropertyOfAxiom(
					factory.getOWLAnnotationProperty(prefixManager.getIRI(args[0])),
					factory.getOWLAnnotationProperty(prefixManager.getIRI(args[1])));
		case SUB_DATA_PROPERTY:
			return factory.getOWLSubDataPropertyOfAxiom(
					factory.getOWLDataProperty(prefixManager.getIRI(args[0])),
					factory.getOWLDataProperty(prefixManager.getIRI(args[1])));
		case SUB_OBJECT_PROPERTY:
			return factory.getOWLSubObjectPropertyOfAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])),
					factory.getOWLObjectProperty(prefixManager.getIRI(args[1])));
		case SUB_PROPERTY_CHAIN_OF:
			List<OWLObjectProperty> chainObjectProperties = new ArrayList<>();
			for (int i = 0; i < args.length-1; i++) {
				chainObjectProperties.add(factory.getOWLObjectProperty(prefixManager.getIRI(args[i])));
			}
			return factory.getOWLSubPropertyChainOfAxiom(
					chainObjectProperties,
					factory.getOWLObjectProperty(prefixManager.getIRI(args[args.length - 1])));
		case SWRL_RULE:
			throw new UnsupportedOperationException();
		case SYMMETRIC_OBJECT_PROPERTY:
			return factory.getOWLSymmetricObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		case TRANSITIVE_OBJECT_PROPERTY:
			return factory.getOWLTransitiveObjectPropertyAxiom(
					factory.getOWLObjectProperty(prefixManager.getIRI(args[0])));
		default:
			return null;
		}
		// @formatter:on
	}

	private void getOWLLiteral(String arg) throws ConverterException {
		String[] parts = Util.splitDatatypeLiteral(arg);
		checkNoVariables(parts);
		String literal = parts[0];
		String language = parts[1];
		String datatype = parts[2];
	}

	private void checkLength(String[] args, int length) throws ConverterException {
		if (length == -1) {
			return;
		}
		if (args.length != length) {
			throw new ConverterException("Initial goal for Annotation assertion should contain 3 arguments");
		}
	}

	private void checkNoVariables(String[] args) throws ConverterException {
		for (String arg : args) {
			checkNoVariable(arg);
		}
	}

	private void checkNoVariable(String arg) throws ConverterException {
		if (arg.startsWith("?")) {
			throw new ConverterException("Initial goal should not contain variables");
		}
	}
}
