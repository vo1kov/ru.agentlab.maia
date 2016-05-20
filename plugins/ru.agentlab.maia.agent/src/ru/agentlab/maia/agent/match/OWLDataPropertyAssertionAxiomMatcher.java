package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLDataProperty;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLDataPropertyAssertionAxiomMatcher implements IMatcher<OWLDataPropertyAssertionAxiom> {

	IMatcher<OWLIndividual> subjectMatcher;

	IMatcher<OWLDataProperty> propertyMatcher;

	IMatcher<OWLLiteral> objectMatcher;

	public OWLDataPropertyAssertionAxiomMatcher(IMatcher<OWLIndividual> subject, IMatcher<OWLDataProperty> predicate,
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

}
