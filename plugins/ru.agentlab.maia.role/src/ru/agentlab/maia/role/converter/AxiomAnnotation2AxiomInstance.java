package ru.agentlab.maia.role.converter;

import java.lang.annotation.Annotation;
import java.util.HashSet;
import java.util.Set;

import javax.inject.Inject;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLDataFactory;
import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLOntologyManager;

import ru.agentlab.maia.exception.ConverterException;
import ru.agentlab.maia.role.AxiomType;

public class AxiomAnnotation2AxiomInstance {

	@Inject
	OWLOntologyManager manager;

	@Inject
	OWLDataFactory factory;

	public OWLAxiom getAxiom(Annotation ann) throws ConverterException {
		AxiomType type = Util.getMethodValue(ann, "type", AxiomType.class);
		String[] args = Util.getMethodValue(ann, "value", String[].class);
		checkNoVariables(args);
		checkLength(args, type.getArity());
		switch (type) {
		case ANNOTATION_ASSERTION:
			// TODO: value can be literal
			return factory.getOWLAnnotationAssertionAxiom(factory.getOWLAnnotationProperty(IRI.create(args[0])),
					IRI.create(args[1]), IRI.create(args[2]));
		case ANNOTATION_PROPERTY_DOMAIN:
			return factory.getOWLAnnotationPropertyDomainAxiom(factory.getOWLAnnotationProperty(IRI.create(args[0])),
					IRI.create(args[1]));
		case ANNOTATION_PROPERTY_RANGE:
			return factory.getOWLAnnotationPropertyRangeAxiom(factory.getOWLAnnotationProperty(IRI.create(args[0])),
					IRI.create(args[1]));
		case ASYMMETRIC_OBJECT_PROPERTY:
			return factory.getOWLAsymmetricObjectPropertyAxiom(factory.getOWLObjectProperty(IRI.create(args[0])));
		case CLASS_ASSERTION:
			return factory.getOWLClassAssertionAxiom(factory.getOWLClass(IRI.create(args[0])),
					factory.getOWLNamedIndividual(IRI.create(args[1])));
		case DATATYPE_DEFINITION:
			// TODO:
			return factory.getOWLDatatypeDefinitionAxiom(factory.getOWLDatatype(IRI.create(args[0])),
					factory.getOWLDatatype(IRI.create(args[1])));
		case DATA_PROPERTY_ASSERTION:
			return null;
		case DATA_PROPERTY_DOMAIN:
			return null;
		case DATA_PROPERTY_RANGE:
			return null;
		case DECLARATION:
			return null;
		case DIFFERENT_INDIVIDUALS:
			Set<OWLIndividual> differentIndividuals = new HashSet<>();
			for (String arg : args) {
				differentIndividuals.add(factory.getOWLNamedIndividual(IRI.create(arg)));
			}
			return factory.getOWLDifferentIndividualsAxiom(differentIndividuals);
		case DISJOINT_CLASSES:
			Set<OWLClass> disjointClasses = new HashSet<>();
			for (String arg : args) {
				disjointClasses.add(factory.getOWLClass(IRI.create(arg)));
			}
			return factory.getOWLDisjointClassesAxiom(disjointClasses);
		case DISJOINT_DATA_PROPERTIES:
			Set<OWLDataProperty> disjointDataProperties = new HashSet<>();
			for (String arg : args) {
				disjointDataProperties.add(factory.getOWLDataProperty(IRI.create(arg)));
			}
			return factory.getOWLDisjointDataPropertiesAxiom(disjointDataProperties);
		case DISJOINT_OBJECT_PROPERTIES:
			Set<OWLObjectProperty> disjointObjectProperties = new HashSet<>();
			for (String arg : args) {
				disjointObjectProperties.add(factory.getOWLObjectProperty(IRI.create(arg)));
			}
			return factory.getOWLDisjointObjectPropertiesAxiom(disjointObjectProperties);
		case DISJOINT_UNION:
			Set<OWLClassExpression> classExpressions = new HashSet<>();
			for (int i = 1; i < args.length; i++) {
				classExpressions.add(factory.getOWLClass(IRI.create(args[i])));
			}
			return factory.getOWLDisjointUnionAxiom(factory.getOWLClass(IRI.create(args[0])), classExpressions);
		case EQUIVALENT_CLASSES:
			Set<OWLClass> equivalentClasses = new HashSet<>();
			for (String arg : args) {
				equivalentClasses.add(factory.getOWLClass(IRI.create(arg)));
			}
			return factory.getOWLEquivalentClassesAxiom(equivalentClasses);
		case EQUIVALENT_DATA_PROPERTIES:
			Set<OWLDataProperty> equivalentDataProperties = new HashSet<>();
			for (String arg : args) {
				equivalentDataProperties.add(factory.getOWLDataProperty(IRI.create(arg)));
			}
			return factory.getOWLEquivalentDataPropertiesAxiom(equivalentDataProperties);
		case EQUIVALENT_OBJECT_PROPERTIES:
			Set<OWLObjectProperty> equivalentObjectProperties = new HashSet<>();
			for (String arg : args) {
				equivalentObjectProperties.add(factory.getOWLObjectProperty(IRI.create(arg)));
			}
			return factory.getOWLEquivalentObjectPropertiesAxiom(equivalentObjectProperties);
		case FUNCTIONAL_DATA_PROPERTY:
			return factory.getOWLFunctionalDataPropertyAxiom(factory.getOWLDataProperty(IRI.create(args[0])));
		case FUNCTIONAL_OBJECT_PROPERTY:
			return factory.getOWLFunctionalObjectPropertyAxiom(factory.getOWLObjectProperty(IRI.create(args[0])));
		case HAS_KEY:
			return null;
		case INVERSE_FUNCTIONAL_OBJECT_PROPERTY:
			return factory
					.getOWLInverseFunctionalObjectPropertyAxiom(factory.getOWLObjectProperty(IRI.create(args[0])));
		case INVERSE_OBJECT_PROPERTIES:
			return null;
		case IRREFLEXIVE_OBJECT_PROPERTY:
			return factory.getOWLIrreflexiveObjectPropertyAxiom(factory.getOWLObjectProperty(IRI.create(args[0])));
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

	private void checkNoVariables(String[] args) throws ConverterException {
		for (String arg : args) {
			if (arg.startsWith("?")) {
				throw new ConverterException("Initial goal should not contain variables");
			}
		}
	}
}
