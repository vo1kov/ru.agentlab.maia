package ru.agentlab.maia.agent.match.common;

import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLNamedObject;

import ru.agentlab.maia.agent.match.IMatch;
import ru.agentlab.maia.agent.match.IMatcher;

public class OWLDataPropertyMatcher implements IMatcher<OWLDataPropertyAssertionAxiom> {

	IMatcher<OWLNamedObject> subjectMatcher;

	IMatcher<OWLNamedObject> propertyMatcher;

	IMatcher<OWLNamedObject> objectMatcher;

	public OWLDataPropertyMatcher(IMatcher<OWLNamedObject> subject, IMatcher<OWLNamedObject> predicate,
			IMatcher<OWLNamedObject> object) {
		super();
		this.subjectMatcher = subject;
		this.propertyMatcher = predicate;
		this.objectMatcher = object;
	}

	public IMatch match(OWLDataPropertyAssertionAxiom axiom) {
		OWLIndividual subject = axiom.getSubject();
		if (!subject.isNamed()) {
			return null;
		}
		OWLDataPropertyExpression property = axiom.getProperty();
		OWLLiteral object = axiom.getObject();
		IMatch subjectMatch = subjectMatcher.match(subject.asOWLNamedIndividual());
		if (subjectMatch == null) {
			return null;
		}
		IMatch propertyMatch = propertyMatcher.match(property);
		if (propertyMatch == null) {
			return null;
		}
		IMatch objectMatch = subjectMatcher.match(object.asOWLNamedIndividual());
		if (objectMatch == null) {
			return null;
		}
		return null;
	}

}
