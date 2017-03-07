package ru.agentlab.maia.service.message.fipa;

import org.semanticweb.owlapi.model.OWLAxiom;

@FunctionalInterface
public interface IBeliefParser {

	OWLAxiom parse(String content);

}
