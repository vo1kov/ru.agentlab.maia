package ru.agentlab.maia;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.semanticweb.owlapi.model.OWLAxiom;

import ru.agentlab.maia.exception.ConverterException;

public interface IConverter {

	Map<IPlan, EventType> getInitialPlans(Object role) throws ConverterException;

	Set<OWLAxiom> getInitialBeliefs(Object role) throws ConverterException;

	Set<OWLAxiom> getInitialGoals(Object role) throws ConverterException;

}