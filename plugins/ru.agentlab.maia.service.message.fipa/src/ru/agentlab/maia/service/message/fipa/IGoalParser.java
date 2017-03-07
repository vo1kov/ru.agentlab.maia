package ru.agentlab.maia.service.message.fipa;

import org.semanticweb.owlapi.model.OWLIndividualAxiom;

@FunctionalInterface
public interface IGoalParser {

	OWLIndividualAxiom parse(String content);

}
