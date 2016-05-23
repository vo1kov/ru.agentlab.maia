package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

public class OWLObjectPropertyAssertionAxiomMatcher implements IMatcher<OWLObjectPropertyAssertionAxiom> {

	IMatcher<? super IRI> subjectMatcher;

	IMatcher<? super IRI> propertyMatcher;

	IMatcher<? super IRI> objectMatcher;

	public OWLObjectPropertyAssertionAxiomMatcher(IMatcher<? super IRI> subject, IMatcher<? super IRI> predicate,
			IMatcher<? super IRI> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public boolean match(OWLObjectPropertyAssertionAxiom axiom, Map<String, Object> map) {
		OWLIndividual subject = axiom.getSubject();
		OWLObjectPropertyExpression property = axiom.getProperty();
		OWLIndividual object = axiom.getObject();
		if (!subject.isNamed() || !object.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual().getIRI(), map)
				&& propertyMatcher.match(property.asOWLObjectProperty().getIRI(), map)
				&& objectMatcher.match(object.asOWLNamedIndividual().getIRI(), map);
	}

	@Override
	public String toString() {
		return "ObjectPropertyMatcher " + "(" + subjectMatcher.toString() + " " + propertyMatcher.toString()
				+ objectMatcher.toString() + ")";
	}

	@Override
	public Class<?> getType() {
		return OWLObjectPropertyAssertionAxiom.class;
	}

}
