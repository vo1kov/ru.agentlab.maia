package ru.agentlab.maia.agent;

import java.util.List;
import java.util.Map;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.EventType;
import ru.agentlab.maia.IPlan;
import ru.agentlab.maia.agent.converter.ConverterException;

public interface IConverter {

	Map<IPlan, EventType> getPlans(Object role) throws ConverterException;

	List<OWLAxiom> getInitialBeliefs(Object role) throws ConverterException;

	List<OWLAxiom> getInitialGoals(Object role) throws ConverterException;

}