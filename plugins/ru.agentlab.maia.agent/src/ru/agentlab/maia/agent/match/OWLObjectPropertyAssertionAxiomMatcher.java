package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedIndividual;
import org.semanticweb.owlapi.model.OWLObjectProperty;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

public class OWLObjectPropertyAssertionAxiomMatcher implements IMatcher<OWLObjectPropertyAssertionAxiom> {

	IMatcher<? super OWLNamedIndividual> subjectMatcher;

	IMatcher<? super OWLObjectProperty> propertyMatcher;

	IMatcher<? super OWLNamedIndividual> objectMatcher;

	public OWLObjectPropertyAssertionAxiomMatcher(IMatcher<? super OWLNamedIndividual> subject,
			IMatcher<? super OWLObjectProperty> predicate, IMatcher<? super OWLNamedIndividual> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public boolean match(OWLObjectPropertyAssertionAxiom axiom, Map<String, Object> map) {
		OWLIndividual subject = axiom.getSubject();
		OWLObjectPropertyExpression property = axiom.getProperty();
		OWLIndividual object = axiom.getObject();
		if (!subject.isNamed() || !object.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual(), map)
				&& propertyMatcher.match(property.asOWLObjectProperty(), map)
				&& objectMatcher.match(object.asOWLNamedIndividual(), map);
	}

	@Override
	public String toString() {
		return "ObjectPropertyMatcher " + "(" + subjectMatcher.toString() + " " + propertyMatcher.toString()
				+ objectMatcher.toString() + ")";
	}

	@Override
	public Class<OWLObjectPropertyAssertionAxiom> getType() {
		return OWLObjectPropertyAssertionAxiom.class;
	}

}
