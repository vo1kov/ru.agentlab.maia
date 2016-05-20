package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

public class OWLObjectPropertyAssertionAxiomMatcher implements IMatcher<OWLObjectPropertyAssertionAxiom> {

	IMatcher<OWLIndividual> subjectMatcher;

	IMatcher<OWLObjectProperty> propertyMatcher;

	IMatcher<OWLIndividual> objectMatcher;

	public OWLObjectPropertyAssertionAxiomMatcher(IMatcher<OWLIndividual> subject,
			IMatcher<OWLObjectProperty> predicate, IMatcher<OWLIndividual> object) {
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

}
