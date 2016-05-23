package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

public class OWLObjectPropertyAssertionAxiomMatcher implements IMatcher<OWLObjectPropertyAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> propertyMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public OWLObjectPropertyAssertionAxiomMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> predicate,
			IMatcher<OWLNamedObject> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public boolean match(OWLObjectPropertyAssertionAxiom axiom, IUnifier unifier) {
		OWLIndividual subject = axiom.getSubject();
		OWLObjectPropertyExpression property = axiom.getProperty();
		OWLIndividual object = axiom.getObject();
		if (!subject.isNamed() || !object.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual(), unifier)
				&& propertyMatcher.match(property.asOWLObjectProperty(), unifier)
				&& objectMatcher.match(object.asOWLNamedIndividual(), unifier);
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
