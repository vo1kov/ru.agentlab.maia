package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;

public class OWLClassAssertionAxiomMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public OWLClassAssertionAxiomMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> object) {
		super();
		this.subjectMatcher = subject;
		this.objectMatcher = object;
	}

	public boolean match(OWLClassAssertionAxiom axiom, IUnifier unifier) {
		OWLIndividual subject = axiom.getIndividual();
		OWLClassExpression object = axiom.getClassExpression();
		if (!subject.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual(), unifier)
				&& objectMatcher.match(object.asOWLClass(), unifier);
	}

	@Override
	public String toString() {
		return "ClassAssertionMatcher " + "(" + subjectMatcher.toString() + " " + objectMatcher.toString() + ")";
	}

	@Override
	public Class<?> getType() {
		return OWLClassAssertionAxiom.class;
	}

}
