package ru.agentlab.maia.agent.match;

import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLClassAssertionAxiomMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<OWLNamedIndividual> subjectMatcher;

	IMatcher<OWLClass> objectMatcher;

	public OWLClassAssertionAxiomMatcher(IMatcher<OWLNamedIndividual> subject, IMatcher<OWLClass> object) {
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

}
