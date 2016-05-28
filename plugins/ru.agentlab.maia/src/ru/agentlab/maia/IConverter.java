package ru.agentlab.maia;

import java.util.List;
import java.util.Map;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.exception.ConverterException;

public interface IConverter {

	Map<IPlan, EventType> getPlans(Object role) throws ConverterException;

	List<OWLAxiom> getInitialBeliefs(Object role) throws ConverterException;

	List<OWLAxiom> getInitialGoals(Object role) throws ConverterException;

}