package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLDataPropertyAssertionAxiomMatcher implements IMatcher<OWLDataPropertyAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> propertyMatcher;

	IMatcher<OWLLiteral> objectMatcher;

	public OWLDataPropertyAssertionAxiomMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> predicate,
			IMatcher<OWLLiteral> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public boolean match(OWLDataPropertyAssertionAxiom axiom, IUnifier unifier) {
		OWLIndividual subject = axiom.getSubject();
		OWLDataPropertyExpression property = axiom.getProperty();
		OWLLiteral object = axiom.getObject();
		if (!subject.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual(), unifier)
				&& propertyMatcher.match(property.asOWLDataProperty(), unifier) && objectMatcher.match(object, unifier);
	}

	@Override
	public String toString() {
		return "DataPropertyMatcher " + "(" + subjectMatcher.toString() + " " + propertyMatcher.toString()
				+ objectMatcher.toString() + ")";
	}

	@Override
	public Class<?> getType() {
		return OWLDataPropertyAssertionAxiom.class;
	}

}
