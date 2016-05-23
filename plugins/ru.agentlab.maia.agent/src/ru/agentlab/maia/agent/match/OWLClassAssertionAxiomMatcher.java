package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLClassAssertionAxiomMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<? super OWLNamedIndividual> subjectMatcher;

	IMatcher<? super OWLClass> objectMatcher;

	public OWLClassAssertionAxiomMatcher(IMatcher<? super OWLNamedIndividual> subject, IMatcher<? super OWLClass> object) {
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
		return subjectMatcher.match(subject.asOWLNamedIndividual(), map)
				&& objectMatcher.match(object.asOWLClass(), map);
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
