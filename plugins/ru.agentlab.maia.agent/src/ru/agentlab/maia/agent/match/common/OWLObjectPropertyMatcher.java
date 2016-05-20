package ru.agentlab.maia.agent.match.common;

import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLNamedObject;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;

public class OWLObjectPropertyMatcher implements IMatcher<OWLObjectPropertyAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> propertyMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public OWLObjectPropertyMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> predicate,
			IMatcher<OWLNamedObject> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public IMatch match(OWLObjectPropertyAssertionAxiom axiom) {
		OWLIndividual subject = axiom.getSubject();
		if (!subject.isNamed()) {
			return null;
		}
		OWLObjectPropertyExpression property = axiom.getProperty();
		OWLIndividual object = axiom.getObject();
		if (!object.isNamed()) {
			return null;
		}
		IMatch subjectMatch = subjectMatcher.match(subject.asOWLNamedIndividual());
		if (subjectMatch == null) {
			return null;
		}
		IMatch propertyMatch = propertyMatcher.match(property.getNamedProperty());
		if (propertyMatch == null) {
			return null;
		}
		IMatch objectMatch = subjectMatcher.match(object.asOWLNamedIndividual());
		return objectMatch;
	}

}
