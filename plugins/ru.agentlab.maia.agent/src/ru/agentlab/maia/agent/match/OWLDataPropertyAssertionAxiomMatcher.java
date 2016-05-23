package ru.agentlab.maia.agent.match;

import java.util.Map;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;

public class OWLDataPropertyAssertionAxiomMatcher implements IMatcher<OWLDataPropertyAssertionAxiom> {

	IMatcher<? super IRI> subjectMatcher;

	IMatcher<? super IRI> propertyMatcher;

	IMatcher<? super OWLLiteral> objectMatcher;

	public OWLDataPropertyAssertionAxiomMatcher(IMatcher<? super IRI> subject, IMatcher<? super IRI> predicate,
			IMatcher<? super OWLLiteral> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public boolean match(OWLDataPropertyAssertionAxiom axiom, Map<String, Object> map) {
		OWLIndividual subject = axiom.getSubject();
		OWLDataPropertyExpression property = axiom.getProperty();
		OWLLiteral object = axiom.getObject();
		if (!subject.isNamed()) {
			return false;
		}
		return subjectMatcher.match(subject.asOWLNamedIndividual().getIRI(), map)
				&& propertyMatcher.match(property.asOWLDataProperty().getIRI(), map)
				&& objectMatcher.match(object, map);
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
