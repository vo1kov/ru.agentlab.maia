package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;

public class OWLClassAssertionAxiomMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<? super IRI> subjectMatcher;

	IMatcher<? super IRI> objectMatcher;

	public OWLClassAssertionAxiomMatcher(IMatcher<? super IRI> subject, IMatcher<? super IRI> object) {
		super();
		this.subjectMatcher = subject;
		this.objectMatcher = object;
	}

	public boolean match(OWLClassAssertionAxiom axiom, Map<String, Object> map) {
		OWLIndividual subject = axiom.getIndividual();
		OWLClassExpression object = axiom.getClassExpression();
		if (!subject.isNamed() || object.isAnonymous()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual().getIRI(), map)
				&& objectMatcher.match(object.asOWLClass().getIRI(), map);
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
