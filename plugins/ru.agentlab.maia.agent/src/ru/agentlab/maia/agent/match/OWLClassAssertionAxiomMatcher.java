package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLClass;
import org.semanticweb.owlapi.model.OWLClassAssertionAxiom;
import org.semanticweb.owlapi.model.OWLClassExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;

public class OWLClassAssertionAxiomMatcher implements IMatcher<OWLClassAssertionAxiom> {

	IMatcher<? super OWLNamedIndividual> individualMatcher;

	IMatcher<? super OWLClass> classMatcher;

	public OWLClassAssertionAxiomMatcher(IMatcher<? super OWLClass> classMatcher,
			IMatcher<? super OWLNamedIndividual> individualMatcher) {
		super();
		this.classMatcher = classMatcher;
		this.individualMatcher = individualMatcher;
	}

	public boolean match(OWLClassAssertionAxiom axiom, Map<String, Object> map) {
		OWLIndividual subject = axiom.getIndividual();
		OWLClassExpression object = axiom.getClassExpression();
		if (!subject.isNamed() || object.isAnonymous()) {
			return false;
		}
		return classMatcher.match(object.asOWLClass(), map)
				&& individualMatcher.match(subject.asOWLNamedIndividual(), map);
	}

	@Override
	public String toString() {
		return "ClassAssertionMatcher " + "(" + individualMatcher.toString() + " " + classMatcher.toString() + ")";
	}

	@Override
	public Class<?> getType() {
		return OWLClassAssertionAxiom.class;
	}

}
