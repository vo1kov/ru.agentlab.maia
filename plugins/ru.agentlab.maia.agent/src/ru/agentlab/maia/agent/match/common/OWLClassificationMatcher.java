package ru.agentlab.maia.agent.match.common;

import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;

public class OWLClassificationMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public OWLClassificationMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> object) {
		super();
		this.subjectMatcher = subject;
		this.objectMatcher = object;
	}

	public IMatch match(OWLClassAssertionAxiom axiom) {
		OWLIndividual subject = axiom.getIndividual();
		if (!subject.isNamed()) {
			return null;
		}
		OWLClassExpression object = axiom.getClassExpression();
		IMatch subjectMatch = subjectMatcher.match(subject.asOWLNamedIndividual());
		if (subjectMatch == null) {
			return null;
		}
		IMatch objectMatch = subjectMatcher.match(object.asOWLClass());
		return objectMatch;
	}

}
