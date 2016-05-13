package ru.agentlab.maia.event.match;

import org.semanticweb.owlapi.model.IRI;
import org.semanticweb.owlapi.model.OWLDataPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLDataPropertyExpression;
import org.semanticweb.owlapi.model.OWLIndividual;
import org.semanticweb.owlapi.model.OWLLiteral;
import org.semanticweb.owlapi.model.OWLObjectPropertyAssertionAxiom;
import org.semanticweb.owlapi.model.OWLObjectPropertyExpression;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IEvent;
import ru.agentlab.maia.agent.IEventMatch;
import ru.agentlab.maia.agent.IEventMatcher;

public class BeliefBaseEventMatcher implements IEventMatcher {

	String subject;

	String predicate;

	String object;

	public BeliefBaseEventMatcher(String subject, String predicate, String object) {
		this.subject = subject;
		this.predicate = predicate;
		this.object = object;
	}

	@Override
	public IEventMatch match(IEvent event) {
		if (event.getType() != EventType.AGENT_BELIEF_ADDED) {

		}
		Object payload = event.getPayload();
		if (payload instanceof OWLObjectPropertyAssertionAxiom) {
			OWLObjectPropertyAssertionAxiom axiom = (OWLObjectPropertyAssertionAxiom) payload;
			OWLIndividual subject = axiom.getSubject();
			if (subject.isNamed()) {
				IRI subjectIRI = subject.asOWLNamedIndividual().getIRI();
			}
			OWLObjectPropertyExpression property = axiom.getProperty();
			OWLIndividual object = axiom.getObject();
		} else if (payload instanceof OWLDataPropertyAssertionAxiom) {
			OWLDataPropertyAssertionAxiom axiom = (OWLDataPropertyAssertionAxiom) payload;
			OWLIndividual subject = axiom.getSubject();
			OWLDataPropertyExpression property = axiom.getProperty();
			OWLLiteral object = axiom.getObject();
		}
		return null;
	}

}
