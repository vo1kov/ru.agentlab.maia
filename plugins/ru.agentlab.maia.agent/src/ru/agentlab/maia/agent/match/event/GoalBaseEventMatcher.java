package ru.agentlab.maia.agent.match.event;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

import ru.agentlab.maia.agent.IEventMatcher;
import ru.agentlab.maia.agent.event.GoalBaseEvent;

public class GoalBaseEventMatcher implements IEventMatcher<OWLAxiom> {

	Class<? extends GoalBaseEvent> eventType;

	String subject;

	String predicate;

	String object;

	public GoalBaseEventMatcher(Class<? extends GoalBaseEvent> eventType, String subject, String predicate,
			String object) {
		this.eventType = eventType;
		this.subject = subject;
		this.predicate = predicate;
		this.object = object;
	}

	@SuppressWarnings("unused")
	@Override
	public boolean match(OWLAxiom eventData) {
		if (eventData instanceof OWLObjectPropertyAssertionAxiom) {
			OWLObjectPropertyAssertionAxiom axiom = (OWLObjectPropertyAssertionAxiom) eventData;
			OWLIndividual subjectIndividual = axiom.getSubject();
			if (subjectIndividual.isNamed()) {
				IRI subjectIRI = subjectIndividual.asOWLNamedIndividual().getIRI();
				if (subject != null) {
					if (!subjectIRI.toString().equalsIgnoreCase(subject)) {
						return false;
					}
				}
			}
			OWLObjectPropertyExpression predicateProperty = axiom.getProperty();
			if (predicate != null) {
				if (!predicateProperty.getNamedProperty().getIRI().toString().equalsIgnoreCase(predicate)) {
					return false;
				}
			}
			OWLIndividual objectIndividual = axiom.getObject();
			if (object != null) {
				if (!objectIndividual.asOWLNamedIndividual().getIRI().toString().equalsIgnoreCase(predicate)) {
					return false;
				}
			}
			return true;
		} else if (eventData instanceof OWLDataPropertyAssertionAxiom) {
			OWLDataPropertyAssertionAxiom axiom = (OWLDataPropertyAssertionAxiom) eventData;
			OWLIndividual subject = axiom.getSubject();
			OWLDataPropertyExpression property = axiom.getProperty();
			OWLLiteral object = axiom.getObject();
		}
		return false;
	}

}
